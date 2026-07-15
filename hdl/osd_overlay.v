`timescale 1ns / 100ps

module bin2bcd(
    input [9:0] bin,
    output reg [3:0] bcd2,
    output reg [3:0] bcd1,
    output reg [3:0] bcd0
);
    integer i;
    always @(*) begin
        bcd2 = 0; bcd1 = 0; bcd0 = 0;
        for (i=9; i>=0; i=i-1) begin
            if (bcd2 >= 5) bcd2 = bcd2 + 3;
            if (bcd1 >= 5) bcd1 = bcd1 + 3;
            if (bcd0 >= 5) bcd0 = bcd0 + 3;
            bcd2 = {bcd2[2:0], bcd1[3]};
            bcd1 = {bcd1[2:0], bcd0[3]};
            bcd0 = {bcd0[2:0], bin[i]};
        end
    end
endmodule

module font5x7(
    input [4:0] char,
    input [2:0] x, // 0 to 4
    input [2:0] y, // 0 to 6
    output pixel
);
    reg [6:0] col; 
    wire [2:0] flipped_x = 3'd4 - x; 
    
    always @(*) begin
        case(char)
            0: case(flipped_x) 0:col=7'h3E; 1:col=7'h51; 2:col=7'h49; 3:col=7'h45; 4:col=7'h3E; default:col=0; endcase
            1: case(flipped_x) 0:col=7'h00; 1:col=7'h42; 2:col=7'h7F; 3:col=7'h40; 4:col=7'h00; default:col=0; endcase
            2: case(flipped_x) 0:col=7'h42; 1:col=7'h61; 2:col=7'h51; 3:col=7'h49; 4:col=7'h46; default:col=0; endcase
            3: case(flipped_x) 0:col=7'h21; 1:col=7'h41; 2:col=7'h45; 3:col=7'h4B; 4:col=7'h31; default:col=0; endcase
            4: case(flipped_x) 0:col=7'h18; 1:col=7'h14; 2:col=7'h12; 3:col=7'h7F; 4:col=7'h10; default:col=0; endcase
            5: case(flipped_x) 0:col=7'h27; 1:col=7'h45; 2:col=7'h45; 3:col=7'h45; 4:col=7'h39; default:col=0; endcase
            6: case(flipped_x) 0:col=7'h3C; 1:col=7'h4A; 2:col=7'h49; 3:col=7'h49; 4:col=7'h30; default:col=0; endcase
            7: case(flipped_x) 0:col=7'h01; 1:col=7'h71; 2:col=7'h09; 3:col=7'h05; 4:col=7'h03; default:col=0; endcase
            8: case(flipped_x) 0:col=7'h36; 1:col=7'h49; 2:col=7'h49; 3:col=7'h49; 4:col=7'h36; default:col=0; endcase
            9: case(flipped_x) 0:col=7'h06; 1:col=7'h49; 2:col=7'h49; 3:col=7'h29; 4:col=7'h1E; default:col=0; endcase
            10: case(flipped_x) 0:col=7'h63; 1:col=7'h14; 2:col=7'h08; 3:col=7'h14; 4:col=7'h63; default:col=0; endcase // X
            11: case(flipped_x) 0:col=7'h03; 1:col=7'h04; 2:col=7'h78; 3:col=7'h04; 4:col=7'h03; default:col=0; endcase // Y
            12: case(flipped_x) 0:col=7'h00; 1:col=7'h36; 2:col=7'h36; 3:col=7'h00; 4:col=7'h00; default:col=0; endcase // :
            13: case(flipped_x) 0:col=7'h7F; 1:col=7'h04; 2:col=7'h08; 3:col=7'h10; 4:col=7'h7F; default:col=0; endcase // N
            14: case(flipped_x) 0:col=7'h3E; 1:col=7'h41; 2:col=7'h41; 3:col=7'h41; 4:col=7'h3E; default:col=0; endcase // O
            15: case(flipped_x) 0:col=7'h7F; 1:col=7'h41; 2:col=7'h41; 3:col=7'h22; 4:col=7'h1C; default:col=0; endcase // D
            16: case(flipped_x) 0:col=7'h01; 1:col=7'h01; 2:col=7'h7F; 3:col=7'h01; 4:col=7'h01; default:col=0; endcase // T
            17: case(flipped_x) 0:col=7'h00; 1:col=7'h00; 2:col=7'h00; 3:col=7'h00; 4:col=7'h00; default:col=0; endcase // space
            18: case(flipped_x) 0:col=7'h3E; 1:col=7'h41; 2:col=7'h41; 3:col=7'h41; 4:col=7'h22; default:col=0; endcase // C
            19: case(flipped_x) 0:col=7'h7F; 1:col=7'h40; 2:col=7'h40; 3:col=7'h40; 4:col=7'h40; default:col=0; endcase // L
            20: case(flipped_x) 0:col=7'h7F; 1:col=7'h09; 2:col=7'h19; 3:col=7'h29; 4:col=7'h46; default:col=0; endcase // R
            21: case(flipped_x) 0:col=7'h7F; 1:col=7'h49; 2:col=7'h49; 3:col=7'h49; 4:col=7'h41; default:col=0; endcase // E
            22: case(flipped_x) 0:col=7'h3E; 1:col=7'h41; 2:col=7'h49; 3:col=7'h49; 4:col=7'h3A; default:col=0; endcase // G
            23: case(flipped_x) 0:col=7'h7F; 1:col=7'h49; 2:col=7'h49; 3:col=7'h49; 4:col=7'h36; default:col=0; endcase // B
            24: case(flipped_x) 0:col=7'h7F; 1:col=7'h08; 2:col=7'h14; 3:col=7'h22; 4:col=7'h41; default:col=0; endcase // K
            default: col=0;
        endcase
    end
    assign pixel = col[y];
endmodule

module osd_engine(
    input [9:0] px,
    input [9:0] py,
    input [9:0] dot_x,
    input [9:0] dot_y,
    input dot_valid,
    input [1:0] dot_color,
    output is_text,
    output is_bg,
    output is_circle
);
    wire [3:0] x2, x1, x0;
    wire [3:0] y2, y1, y0;
    bin2bcd bcdx(dot_x, x2, x1, x0);
    bin2bcd bcdy(dot_y, y2, y1, y0);
    
    // Multiplexers for the dynamic color string output
    wire [4:0] c_char1 = (dot_color == 2'd1) ? 5'd20 : (dot_color == 2'd2) ? 5'd22 : 5'd23; // R, G, B
    wire [4:0] c_char2 = (dot_color == 2'd1) ? 5'd21 : (dot_color == 2'd2) ? 5'd20 : 5'd19; // E, R, L
    wire [4:0] c_char3 = (dot_color == 2'd1) ? 5'd15 : (dot_color == 2'd2) ? 5'd13 : 5'd24; // D, N, K

    reg [4:0] char_sel;
    reg in_box;
    reg [3:0] cx_offset;
    reg [4:0] cy_offset;
    
    always @(*) begin
        in_box = 0;
        char_sel = 0;
        cx_offset = 0;
        cy_offset = 0;
        
        // ROW 1: X-coordinate OR "NODOT"
        if (py >= 10 && py < 31) begin
            cy_offset = py - 10;
            if      (px >= 461 && px <= 475) begin in_box = 1; char_sel = dot_valid ? 10 : 13; cx_offset = px - 461; end 
            else if (px >= 443 && px <= 457) begin in_box = 1; char_sel = dot_valid ? 12 : 14; cx_offset = px - 443; end 
            else if (px >= 407 && px <= 421) begin in_box = 1; char_sel = dot_valid ? x2 : 15; cx_offset = px - 407; end 
            else if (px >= 389 && px <= 403) begin in_box = 1; char_sel = dot_valid ? x1 : 14; cx_offset = px - 389; end 
            else if (px >= 371 && px <= 385) begin in_box = 1; char_sel = dot_valid ? x0 : 16; cx_offset = px - 371; end 
        end
        // ROW 2: Y-coordinate
        else if (py >= 40 && py < 61) begin
            cy_offset = py - 40;
            if      (px >= 461 && px <= 475) begin in_box = 1; char_sel = dot_valid ? 11 : 17; cx_offset = px - 461; end 
            else if (px >= 443 && px <= 457) begin in_box = 1; char_sel = dot_valid ? 12 : 17; cx_offset = px - 443; end 
            else if (px >= 407 && px <= 421) begin in_box = 1; char_sel = dot_valid ? y2 : 17; cx_offset = px - 407; end 
            else if (px >= 389 && px <= 403) begin in_box = 1; char_sel = dot_valid ? y1 : 17; cx_offset = px - 389; end 
            else if (px >= 371 && px <= 385) begin in_box = 1; char_sel = dot_valid ? y0 : 17; cx_offset = px - 371; end 
        end
        // ROW 3: "CLR: RED", "CLR: GRN", "CLR: BLK"
        else if (py >= 70 && py < 91 && dot_valid) begin
            cy_offset = py - 70;
            if      (px >= 461 && px <= 475) begin in_box = 1; char_sel = 18; cx_offset = px - 461; end // C
            else if (px >= 443 && px <= 457) begin in_box = 1; char_sel = 19; cx_offset = px - 443; end // L
            else if (px >= 425 && px <= 439) begin in_box = 1; char_sel = 20; cx_offset = px - 425; end // R
            else if (px >= 407 && px <= 421) begin in_box = 1; char_sel = 12; cx_offset = px - 407; end // :
            else if (px >= 389 && px <= 403) begin in_box = 1; char_sel = 17; cx_offset = px - 389; end // Space
            else if (px >= 371 && px <= 385) begin in_box = 1; char_sel = c_char1; cx_offset = px - 371; end // char1
            else if (px >= 353 && px <= 367) begin in_box = 1; char_sel = c_char2; cx_offset = px - 353; end // char2
            else if (px >= 335 && px <= 349) begin in_box = 1; char_sel = c_char3; cx_offset = px - 335; end // char3
        end
    end
    
    reg is_circle_reg;
    always @(*) begin
        is_circle_reg = 0;
        if (dot_valid) begin
            if ( (px == dot_x - 15 || px == dot_x + 15) && (py >= dot_y - 15 && py <= dot_y + 15) ) is_circle_reg = 1;
            if ( (py == dot_y - 15 || py == dot_y + 15) && (px >= dot_x - 15 && px <= dot_x + 15) ) is_circle_reg = 1;
        end
    end
    assign is_circle = is_circle_reg;
    
    function [2:0] div3_x(input [3:0] v);
        case(v)
            0,1,2: div3_x = 0;
            3,4,5: div3_x = 1;
            6,7,8: div3_x = 2;
            9,10,11: div3_x = 3;
            12,13,14: div3_x = 4;
            default: div3_x = 0;
        endcase
    endfunction

    function [2:0] div3_y(input [4:0] v);
        case(v)
            0,1,2: div3_y = 0;
            3,4,5: div3_y = 1;
            6,7,8: div3_y = 2;
            9,10,11: div3_y = 3;
            12,13,14: div3_y = 4;
            15,16,17: div3_y = 5;
            18,19,20: div3_y = 6;
            default: div3_y = 0;
        endcase
    endfunction
    
    wire pixel;
    font5x7 fnt(
        .char(char_sel),
        .x(div3_x(cx_offset)),
        .y(div3_y(cy_offset)),
        .pixel(pixel)
    );
    
    assign is_text = in_box & pixel;
    assign is_bg = in_box & ~pixel;
    
endmodule

module osd_overlay (
    input clk,
    input resetn,
    input vsync,
    input [9:0] dot_x,
    input [9:0] dot_y,
    input dot_valid,
    input [1:0] dot_color,
    
    // Inputs from LCD_FSM
    input fsm_cs_o,
    input fsm_dc_o,
    input fsm_wr_o,
    input [7:0] fsm_data_o,
    
    // Outputs to MUX
    output cs_o,
    output dc_o,
    output wr_o,
    output [7:0] data_o
);

    assign cs_o = fsm_cs_o;
    assign dc_o = fsm_dc_o;
    assign wr_o = fsm_wr_o;
    
    reg fsm_wr_o_prev;
    reg byte_phase;
    reg [9:0] x_cnt;
    reg [9:0] y_cnt;
    
  always @(posedge clk) begin
    if (!resetn || vsync) begin
        x_cnt <= 0;
        y_cnt <= 0;
        byte_phase <= 0;
        fsm_wr_o_prev <= 1;
    end else begin
        fsm_wr_o_prev <= fsm_wr_o;
        if (fsm_wr_o_prev == 0 && fsm_wr_o == 1 && fsm_cs_o == 0 && fsm_dc_o == 1) begin
            byte_phase <= ~byte_phase;
            if (byte_phase == 0) begin 
                if (x_cnt == 479) begin
                    x_cnt <= 0;
                    if (y_cnt == 319)
                        y_cnt <= 0;
                    else
                        y_cnt <= y_cnt + 1;
                end else begin
                    x_cnt <= x_cnt + 1;
                end
            end
        end
    end
end
    wire is_text, is_bg, is_circle;
    osd_engine eng (
        .px(x_cnt),
        .py(y_cnt),
        .dot_x(dot_x),
        .dot_y(dot_y),
        .dot_valid(dot_valid),
        .dot_color(dot_color),
        .is_text(is_text),
        .is_bg(is_bg),
        .is_circle(is_circle)
    );
    
    wire [7:0] overlay_color = is_circle ? (byte_phase ? 8'h00 : 8'hF8) : (is_text ? 8'h00 : 8'hFF);
    assign data_o = (fsm_cs_o == 0 && fsm_dc_o == 1 && (is_text || is_bg || is_circle)) ? overlay_color : fsm_data_o;

endmodule