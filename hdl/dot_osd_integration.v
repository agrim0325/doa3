`timescale 1ns / 100ps

module dot_osd_integration (
    // Camera signals (to track the dot)
    input  wire        pclk_i,
    input  wire        reset_n_i,
    input  wire        h_ref_i,
    input  wire        v_sync_i,
    input  wire [7:0]  data_i,
    input  wire        sys_clk_i,
    
    // Video signals coming FROM line_write_read (Hardware video stream)
    input  wire        fsm_cs_o,
    input  wire        fsm_dc_o,
    input  wire        fsm_wr_o,
    input  wire [7:0]  fsm_data_o,
    
    // Video signals going TO mux_2_1 (LCD Controller)
    output wire        cs_o,
    output wire        dc_o,
    output wire        wr_o,
    output wire [7:0]  data_o
);

    wire [9:0] dot_x;
    wire [9:0] dot_y;
    wire       dot_valid;

    dot_detector tracker (
        .pclk_i      ( pclk_i ),
        .reset_n_i   ( reset_n_i ),
        .h_ref_i     ( h_ref_i ),
        .v_sync_i    ( v_sync_i ),
        .data_i      ( data_i ),
        .sys_clk_i   ( sys_clk_i ),
        .threshold_i ( 8'h30 ), // Fixed threshold for dark black dot
        .read_cell_i ( 3'b000 ),
        .read_reg_i  ( 3'b000 ),
        .read_data_o ( ),
        .center_x    ( dot_x ),
        .center_y    ( dot_y ),
        .dot_valid   ( dot_valid )
    );

    osd_overlay overlay (
        .clk        ( sys_clk_i ),
        .resetn     ( reset_n_i ),
        .vsync      ( v_sync_i ),
        .dot_x      ( dot_x ),
        .dot_y      ( dot_y ),
        .dot_valid  ( dot_valid ),
        
        .fsm_cs_o   ( fsm_cs_o ),
        .fsm_dc_o   ( fsm_dc_o ),
        .fsm_wr_o   ( fsm_wr_o ),
        .fsm_data_o ( fsm_data_o ),
        
        .cs_o       ( cs_o ),
        .dc_o       ( dc_o ),
        .wr_o       ( wr_o ),
        .data_o     ( data_o )
    );

endmodule
