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
    output wire        dot_valid,
    output wire [1:0]  dot_color // 00=BLK, 01=RED, 10=GRN
);

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
    
    reg [15:0] col_idx;
    reg [15:0] row_idx;
    reg        byte_phase;
    reg [7:0]  first_byte;
    
    reg [15:0] glbl_min_x, glbl_max_x, glbl_min_y, glbl_max_y;
    reg [15:0] out_glbl_min_x, out_glbl_max_x, out_glbl_min_y, out_glbl_max_y;
    
    reg [15:0] cnt_blk, cnt_red, cnt_grn;
    reg [1:0]  out_color;

    wire [4:0] px_red   = first_byte[7:3];
    wire [5:0] px_green = {first_byte[2:0], data_sync2[7:5]};
    wire [4:0] px_blue  = data_sync2[4:0];
    
    // Strict Chromatic Spectral Bounds
    wire is_blk = (px_red < 5'h08) && (px_green < 6'h10) && (px_blue < 5'h08);
    wire is_red = (px_red > 5'h0E) && (px_green < 6'h0A) && (px_blue < 5'h0A);
    wire is_grn = (px_red < 5'h0A) && (px_green > 6'h1C) && (px_blue < 5'h0A);
    
    wire pixel_match = is_blk | is_red | is_grn;
    
    always @(posedge sys_clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            col_idx    <= 16'd0;
            row_idx    <= 16'd0;
            byte_phase <= 1'b0;
            first_byte <= 8'd0;
            
            glbl_min_x <= 16'hFFFF; glbl_max_x <= 16'h0000;
            glbl_min_y <= 16'hFFFF; glbl_max_y <= 16'h0000;
            
            out_glbl_min_x <= 16'h0000; out_glbl_max_x <= 16'h0000;
            out_glbl_min_y <= 16'h0000; out_glbl_max_y <= 16'h0000;
            
            cnt_blk <= 16'd0; cnt_red <= 16'd0; cnt_grn <= 16'd0;
            out_color <= 2'd0;
        end else begin
            if (vsync_rise) begin
                out_glbl_min_x <= glbl_min_x; out_glbl_max_x <= glbl_max_x;
                out_glbl_min_y <= glbl_min_y; out_glbl_max_y <= glbl_max_y;
                
                // Statistical Classification Comparator
                if (cnt_red > cnt_blk && cnt_red > cnt_grn) out_color <= 2'd1;
                else if (cnt_grn > cnt_blk && cnt_grn > cnt_red) out_color <= 2'd2;
                else out_color <= 2'd0;
                
                glbl_min_x <= 16'hFFFF; glbl_max_x <= 16'h0000;
                glbl_min_y <= 16'hFFFF; glbl_max_y <= 16'h0000;
                
                cnt_blk <= 16'd0; cnt_red <= 16'd0; cnt_grn <= 16'd0;
                col_idx <= 16'd0; row_idx <= 16'd0; byte_phase <= 1'b0;
            end else begin
                if (href_fall) begin
                    row_idx    <= row_idx + 1'b1;
                    col_idx    <= 16'd0;
                    byte_phase <= 1'b0;
                end
                if (href_active && pclk_rise) begin
                    if (byte_phase == 1'b0) begin
                        first_byte <= data_sync2;
                        byte_phase <= 1'b1;
                    end else begin
                        byte_phase <= 1'b0;
                        col_idx    <= col_idx + 1'b1;
                        
                        if (pixel_match) begin
                            if (col_idx < glbl_min_x) glbl_min_x <= col_idx;
                            if (col_idx > glbl_max_x) glbl_max_x <= col_idx;
                            if (row_idx < glbl_min_y) glbl_min_y <= row_idx;
                            if (row_idx > glbl_max_y) glbl_max_y <= row_idx;
                        end
                        
                        // Parallel Spectral Density Integration
                        if (is_blk) cnt_blk <= cnt_blk + 1'b1;
                        if (is_red) cnt_red <= cnt_red + 1'b1;
                        if (is_grn) cnt_grn <= cnt_grn + 1'b1;
                    end
                end
            end
        end
    end
    
    always @(*) begin
        case (read_reg_i)
            3'd0: read_data_o = {16'd0, out_glbl_max_x};
            default: read_data_o = 32'd0;
        endcase
    end

    wire [15:0] raw_center_x = (out_glbl_min_x <= out_glbl_max_x) ? ((out_glbl_min_x + out_glbl_max_x) >> 1) : 16'd0;
    wire [15:0] raw_center_y = (out_glbl_min_y <= out_glbl_max_y) ? ((out_glbl_min_y + out_glbl_max_y) >> 1) : 16'd0;

    assign center_x = ((raw_center_x * 3) >> 2);
    assign center_y = ((raw_center_y * 171) >> 8);
    assign dot_valid = (out_glbl_min_x <= out_glbl_max_x) ? 1'b1 : 1'b0;
    assign dot_color = out_color;

endmodule