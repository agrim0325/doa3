module dot_detector #(
    parameter IMG_WIDTH  = 640,
    parameter IMG_HEIGHT = 480
)(
    input  wire        pclk_i,
    input  wire        reset_n_i,
    input  wire        h_ref_i,
    input  wire        v_sync_i,
    input  wire [7:0]  data_i,
    
    input  wire        sys_clk_i,
    input  wire [7:0]  threshold_i,
    
    input  wire [2:0]  read_cell_i,
    input  wire [2:0]  read_reg_i,
    output reg  [31:0] read_data_o,
    
    output wire [9:0]  center_x,
    output wire [9:0]  center_y,
    output wire        dot_valid
);

    // Shift registers for CDC (Clock Domain Crossing) and edge detection
    reg [2:0] pclk_sr, href_sr, vsync_sr;
    reg [7:0] data_sync1, data_sync2;
    
    always @(posedge sys_clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            pclk_sr    <= 3'b000;
            href_sr    <= 3'b000;
            vsync_sr   <= 3'b000;
            data_sync1 <= 8'h00;
            data_sync2 <= 8'h00;
        end else begin
            pclk_sr    <= {pclk_sr[1:0], pclk_i};
            href_sr    <= {href_sr[1:0], h_ref_i};
            vsync_sr   <= {vsync_sr[1:0], v_sync_i};
            data_sync1 <= data_i;
            data_sync2 <= data_sync1;
        end
    end
    
    wire pclk_rise   = (pclk_sr[2:1] == 2'b01);
    wire href_fall   = (href_sr[2:1] == 2'b10);
    wire vsync_rise  = (vsync_sr[2:1] == 2'b01);
    wire href_active = href_sr[2];
    
    // Position counters and byte tracking
    reg [15:0] col_idx;
    reg [15:0] row_idx;
    reg        byte_phase;
    reg [7:0]  first_byte;
    
    // Global bounding box for the entire screen
    reg [15:0] glbl_min_x, glbl_max_x, glbl_min_y, glbl_max_y;
    reg [15:0] out_glbl_min_x, out_glbl_max_x, out_glbl_min_y, out_glbl_max_y;
    
    // RGB extraction from RGB565 format
    wire [4:0] px_red   = first_byte[7:3];
    wire [5:0] px_green = {first_byte[2:0], data_sync2[7:5]};
    wire [4:0] px_blue  = data_sync2[4:0];
    
    // Threshold comparison logic
    wire [4:0] th_r = threshold_i[7:3];
    wire [5:0] th_g = threshold_i[7:2];
    wire [4:0] th_b = threshold_i[7:3];
    
    // FIXED: Must use logical AND to ensure ALL channels are dark (true black dot)
    wire pixel_match = (px_red < th_r) && (px_green < th_g) && (px_blue < th_b);
    
    always @(posedge sys_clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            col_idx    <= 16'd0;
            row_idx    <= 16'd0;
            byte_phase <= 1'b0;
            first_byte <= 8'd0;
            
            glbl_min_x <= 16'hFFFF;
            glbl_max_x <= 16'h0000;
            glbl_min_y <= 16'hFFFF;
            glbl_max_y <= 16'h0000;
            
            out_glbl_min_x <= 16'h0000;
            out_glbl_max_x <= 16'h0000;
            out_glbl_min_y <= 16'h0000;
            out_glbl_max_y <= 16'h0000;

        end else begin
            // VSYNC indicates a new frame
            if (vsync_rise) begin
                
                // Latch global bounding box for this frame
                out_glbl_min_x <= glbl_min_x;
                out_glbl_max_x <= glbl_max_x;
                out_glbl_min_y <= glbl_min_y;
                out_glbl_max_y <= glbl_max_y;
                
                // Reset accumulators for next frame
                glbl_min_x <= 16'hFFFF;
                glbl_max_x <= 16'h0000;
                glbl_min_y <= 16'hFFFF;
                glbl_max_y <= 16'h0000;
                
                col_idx    <= 16'd0;
                row_idx    <= 16'd0;
                byte_phase <= 1'b0;
            end else begin
                // HREF falling edge marks the end of a horizontal line
                if (href_fall) begin
                    row_idx    <= row_idx + 1'b1;
                    col_idx    <= 16'd0;
                    byte_phase <= 1'b0;
                end
                
                // Process valid pixels during active video period
                if (href_active && pclk_rise) begin
                    if (byte_phase == 1'b0) begin
                        first_byte <= data_sync2;
                        byte_phase <= 1'b1;
                    end else begin
                        byte_phase <= 1'b0;
                        col_idx    <= col_idx + 1'b1;
                        
                        // Dynamically scale bounding box across entire 640x480 frame
                        if (pixel_match) begin
                            if (col_idx < glbl_min_x) glbl_min_x <= col_idx;
                            if (col_idx > glbl_max_x) glbl_max_x <= col_idx;
                            if (row_idx < glbl_min_y) glbl_min_y <= row_idx;
                            if (row_idx > glbl_max_y) glbl_max_y <= row_idx;
                        end
                    end
                end
            end
        end
    end
    
    // Shared bus query decoder (legacy support for Cortex-M3 access)
    always @(*) begin
        case (read_reg_i)
            3'd0: read_data_o = {16'd0, out_glbl_max_x}; // Example placeholder mapping
            default: read_data_o = 32'd0;
        endcase
    end

    // Compute center coordinates for OSD (With overflow safety if dot is lost)
    assign center_x = (out_glbl_min_x <= out_glbl_max_x) ? ((out_glbl_min_x + out_glbl_max_x) >> 1) : 10'd0;
    assign center_y = (out_glbl_min_y <= out_glbl_max_y) ? ((out_glbl_min_y + out_glbl_max_y) >> 1) : 10'd0;
    
    // Valid dot if min is less than or equal to max
    assign dot_valid = (out_glbl_min_x <= out_glbl_max_x) ? 1'b1 : 1'b0;

endmodule