//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jul 14 06:56:44 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// TOP
module TOP(
    // Inputs
    DATA_I,
    DEVRST_N_0,
    FF_Entry_SW,
    H_REF_I,
    PCLK_I,
    RX,
    V_SYNC_I,
    Wake_On_Change_SW,
    // Outputs
    CAM_PWDN_O,
    Fabric_Active,
    INIT_DONE,
    LCD_RST_O,
    SW_output,
    TX,
    XCLK,
    cs_o,
    data_o,
    led,
    rd_o,
    rs_o,
    wr_o,
    // Inouts
    SCL,
    SDA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [7:0] DATA_I;
input        DEVRST_N_0;
input        FF_Entry_SW;
input        H_REF_I;
input        PCLK_I;
input        RX;
input        V_SYNC_I;
input        Wake_On_Change_SW;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       CAM_PWDN_O;
output       Fabric_Active;
output       INIT_DONE;
output       LCD_RST_O;
output       SW_output;
output       TX;
output       XCLK;
output       cs_o;
output [7:0] data_o;
output [1:0] led;
output       rd_o;
output       rs_o;
output       wr_o;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout        SCL;
inout        SDA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          apb3_if_0_cs_o;
wire   [7:0]  apb3_if_0_data_o;
wire          apb3_if_0_dc_o;
wire          apb3_if_0_init_done_o;
wire          apb3_if_0_lcd_rd_o;
wire          apb3_if_0_lcd_wr_o;
wire          CAM_PWDN_O_net_0;
wire          cs_o_net_0;
wire   [7:0]  DATA_I;
wire   [7:0]  data_o_0;
wire          DEVRST_N_0;
wire          dot_osd_integration_0_cs_o;
wire   [7:0]  dot_osd_integration_0_data_o;
wire          dot_osd_integration_0_dc_o;
wire          dot_osd_integration_0_wr_o;
wire          Fabric_Active_net_0;
wire          FF_Entry_SW;
wire          FlashFreeze_SB_0_FF_DONE;
wire          FlashFreeze_SB_0_FF_TO_START;
wire   [31:0] FlashFreeze_SB_0_FIC_0_APB_MASTER_PADDR;
wire          FlashFreeze_SB_0_FIC_0_APB_MASTER_PENABLE;
wire          FlashFreeze_SB_0_FIC_0_APB_MASTER_PREADY;
wire          FlashFreeze_SB_0_FIC_0_APB_MASTER_PSELx;
wire          FlashFreeze_SB_0_FIC_0_APB_MASTER_PSLVERR;
wire   [31:0] FlashFreeze_SB_0_FIC_0_APB_MASTER_PWDATA;
wire          FlashFreeze_SB_0_FIC_0_APB_MASTER_PWRITE;
wire          FlashFreeze_SB_0_GL0;
wire          FlashFreeze_SB_0_LOCK;
wire          H_REF_I;
wire          INIT_DONE_net_0;
wire   [1:0]  led_net_0;
wire          line_write_read_0_cs_o;
wire   [7:0]  line_write_read_0_data_o;
wire          line_write_read_0_dc_o;
wire          line_write_read_0_lcd_wr_o;
wire          MX2_0_Y;
wire          OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire          OSC_C0_0_RCOSC_25_50MHZ_O2F;
wire          PCLK_I;
wire          rd_o_net_0;
wire          rs_o_net_0;
wire          RX;
wire          SCL;
wire          SDA;
wire          SW_output_net_0;
wire          SYSRESET_0_POWER_ON_RESET_N_1;
wire          TX_net_0;
wire   [9:0]  UART_interface_0_blue_const_o;
wire   [19:0] UART_interface_0_common_const_o;
wire   [9:0]  UART_interface_0_green_const_o;
wire   [9:0]  UART_interface_0_red_const_o;
wire          V_SYNC_I;
wire          Wake_On_Change_SW;
wire          wr_o_net_0;
wire          XCLK_net_0;
wire          SW_output_net_1;
wire          Fabric_Active_net_1;
wire          INIT_DONE_net_1;
wire          wr_o_net_1;
wire          cs_o_net_1;
wire          rd_o_net_1;
wire          rs_o_net_1;
wire          XCLK_net_1;
wire          CAM_PWDN_O_net_1;
wire          TX_net_1;
wire   [1:0]  led_net_1;
wire   [7:0]  data_o_0_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire   [31:0] FIC_0_APB_M_PRDATA_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                        = 1'b1;
assign FIC_0_APB_M_PRDATA_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign LCD_RST_O           = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SW_output_net_1     = SW_output_net_0;
assign SW_output           = SW_output_net_1;
assign Fabric_Active_net_1 = Fabric_Active_net_0;
assign Fabric_Active       = Fabric_Active_net_1;
assign INIT_DONE_net_1     = INIT_DONE_net_0;
assign INIT_DONE           = INIT_DONE_net_1;
assign wr_o_net_1          = wr_o_net_0;
assign wr_o                = wr_o_net_1;
assign cs_o_net_1          = cs_o_net_0;
assign cs_o                = cs_o_net_1;
assign rd_o_net_1          = rd_o_net_0;
assign rd_o                = rd_o_net_1;
assign rs_o_net_1          = rs_o_net_0;
assign rs_o                = rs_o_net_1;
assign XCLK_net_1          = XCLK_net_0;
assign XCLK                = XCLK_net_1;
assign CAM_PWDN_O_net_1    = CAM_PWDN_O_net_0;
assign CAM_PWDN_O          = CAM_PWDN_O_net_1;
assign TX_net_1            = TX_net_0;
assign TX                  = TX_net_1;
assign led_net_1           = led_net_0;
assign led[1:0]            = led_net_1;
assign data_o_0_net_0      = data_o_0;
assign data_o[7:0]         = data_o_0_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------apb3_if
apb3_if #( 
        .g_APB3_IF_DATA_WIDTH ( 32 ),
        .g_CONST_WIDTH        ( 12 ) )
apb3_if_0(
        // Inputs
        .preset_i    ( INIT_DONE_net_0 ),
        .pclk_i      ( FlashFreeze_SB_0_GL0 ),
        .psel_i      ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PSELx ),
        .pwrite_i    ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PWRITE ),
        .penable_i   ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PENABLE ),
        .paddr_i     ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PADDR ),
        .pwdata_i    ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PWDATA ),
        // Outputs
        .pready_o    ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PREADY ),
        .pslverr_o   ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PSLVERR ),
        .dc_o        ( apb3_if_0_dc_o ),
        .cs_o        ( apb3_if_0_cs_o ),
        .lcd_wr_o    ( apb3_if_0_lcd_wr_o ),
        .lcd_rd_o    ( apb3_if_0_lcd_rd_o ),
        .init_done_o ( apb3_if_0_init_done_o ),
        .data_o      ( apb3_if_0_data_o ) 
        );

//--------FF_GENERATOR
FF_GENERATOR CAMERA_PWDN_GEN(
        // Inputs
        .reset_i       ( INIT_DONE_net_0 ),
        .sys_clk_i     ( FlashFreeze_SB_0_GL0 ),
        .ff_to_start_i ( FlashFreeze_SB_0_FF_TO_START ),
        .ff_done_i     ( FlashFreeze_SB_0_FF_DONE ),
        // Outputs
        .cam_pwdn_o    ( CAM_PWDN_O_net_0 ) 
        );

//--------dot_osd_integration
dot_osd_integration dot_osd_integration_0(
        // Inputs
        .pclk_i     ( PCLK_I ),
        .reset_n_i  ( MX2_0_Y ),
        .h_ref_i    ( H_REF_I ),
        .v_sync_i   ( V_SYNC_I ),
        .sys_clk_i  ( FlashFreeze_SB_0_GL0 ),
        .fsm_cs_o   ( line_write_read_0_cs_o ),
        .fsm_dc_o   ( line_write_read_0_dc_o ),
        .fsm_wr_o   ( line_write_read_0_lcd_wr_o ),
        .data_i     ( DATA_I ),
        .fsm_data_o ( line_write_read_0_data_o ),
        // Outputs
        .cs_o       ( dot_osd_integration_0_cs_o ),
        .dc_o       ( dot_osd_integration_0_dc_o ),
        .wr_o       ( dot_osd_integration_0_wr_o ),
        .data_o     ( dot_osd_integration_0_data_o ) 
        );

//--------FF_EXT
FF_EXT FF_EXT_0(
        // Inputs
        .clk    ( FlashFreeze_SB_0_GL0 ),
        .lock   ( FlashFreeze_SB_0_LOCK ),
        // Outputs
        .tg_out ( Fabric_Active_net_0 ) 
        );

//--------FlashFreeze_SB
FlashFreeze_SB FlashFreeze_SB_0(
        // Inputs
        .FAB_RESET_N         ( VCC_net ),
        .POWER_ON_RESET_N    ( SYSRESET_0_POWER_ON_RESET_N_1 ),
        .RCOSC_25_50MHZ_0    ( OSC_C0_0_RCOSC_25_50MHZ_O2F ),
        .Wake_On_Change_SW   ( Wake_On_Change_SW ),
        .FF_Entry_SW         ( FF_Entry_SW ),
        .RCOSC_25_50MHZ      ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        .FIC_0_APB_M_PREADY  ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PREADY ),
        .FIC_0_APB_M_PSLVERR ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PSLVERR ),
        .FIC_0_APB_M_PRDATA  ( FIC_0_APB_M_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .INIT_DONE           ( INIT_DONE_net_0 ),
        .FF_DONE             ( FlashFreeze_SB_0_FF_DONE ),
        .GL1_XCLK            ( XCLK_net_0 ),
        .GL0                 ( FlashFreeze_SB_0_GL0 ),
        .FIC_0_APB_M_PSEL    ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PSELx ),
        .FIC_0_APB_M_PENABLE ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PENABLE ),
        .FIC_0_APB_M_PWRITE  ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PWRITE ),
        .SW_output           ( SW_output_net_0 ),
        .FF_TO_START         ( FlashFreeze_SB_0_FF_TO_START ),
        .LOCK                ( FlashFreeze_SB_0_LOCK ),
        .FIC_0_APB_M_PADDR   ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PADDR ),
        .FIC_0_APB_M_PWDATA  ( FlashFreeze_SB_0_FIC_0_APB_MASTER_PWDATA ),
        // Inouts
        .SDA                 ( SDA ),
        .SCL                 ( SCL ) 
        );

//--------led_blink
led_blink led_blink_0(
        // Inputs
        .clk  ( FlashFreeze_SB_0_GL0 ),
        .rstn ( MX2_0_Y ),
        // Outputs
        .led  ( led_net_0 ) 
        );

//--------line_write_read
line_write_read line_write_read_0(
        // Inputs
        .H_REF_I        ( H_REF_I ),
        .SYS_CLK_I      ( FlashFreeze_SB_0_GL0 ),
        .RESETN_I       ( MX2_0_Y ),
        .PCLK_I         ( PCLK_I ),
        .V_SYNC_I       ( V_SYNC_I ),
        .init_done_i    ( apb3_if_0_init_done_o ),
        .DATA_I         ( DATA_I ),
        .R_CONST_I      ( UART_interface_0_red_const_o ),
        .G_CONST_I      ( UART_interface_0_green_const_o ),
        .B_CONST_I      ( UART_interface_0_blue_const_o ),
        .COMMON_CONST_I ( UART_interface_0_common_const_o ),
        // Outputs
        .dc_o           ( line_write_read_0_dc_o ),
        .cs_o           ( line_write_read_0_cs_o ),
        .lcd_wr_o       ( line_write_read_0_lcd_wr_o ),
        .data_o         ( line_write_read_0_data_o ) 
        );

//--------mux_2_1
mux_2_1 mux_2_1_0(
        // Inputs
        .sel_i   ( apb3_if_0_init_done_o ),
        .wr1_i   ( apb3_if_0_lcd_wr_o ),
        .wr2_i   ( dot_osd_integration_0_wr_o ),
        .cs1_i   ( apb3_if_0_cs_o ),
        .cs2_i   ( dot_osd_integration_0_cs_o ),
        .dc1_i   ( apb3_if_0_dc_o ),
        .dc2_i   ( dot_osd_integration_0_dc_o ),
        .rd1_i   ( apb3_if_0_lcd_rd_o ),
        .rd2_i   ( VCC_net ),
        .data1_i ( apb3_if_0_data_o ),
        .data2_i ( dot_osd_integration_0_data_o ),
        // Outputs
        .wr_o    ( wr_o_net_0 ),
        .cs_o    ( cs_o_net_0 ),
        .dc_o    ( rs_o_net_0 ),
        .rd_o    ( rd_o_net_0 ),
        .data_o  ( data_o_0 ) 
        );

//--------MX2
MX2 MX2_0(
        // Inputs
        .A ( FlashFreeze_SB_0_LOCK ),
        .B ( VCC_net ),
        .S ( FlashFreeze_SB_0_FF_DONE ),
        // Outputs
        .Y ( MX2_0_Y ) 
        );

//--------OSC_C0
OSC_C0 OSC_C0_0(
        // Outputs
        .RCOSC_25_50MHZ_CCC ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        .RCOSC_25_50MHZ_O2F ( OSC_C0_0_RCOSC_25_50MHZ_O2F ) 
        );

//--------SYSRESET
SYSRESET SYSRESET_0(
        // Inputs
        .DEVRST_N         ( DEVRST_N_0 ),
        // Outputs
        .POWER_ON_RESET_N ( SYSRESET_0_POWER_ON_RESET_N_1 ) 
        );

//--------UART_interface
UART_interface UART_interface_0(
        // Inputs
        .reset_i        ( INIT_DONE_net_0 ),
        .sys_clk_i      ( FlashFreeze_SB_0_GL0 ),
        .RX             ( RX ),
        // Outputs
        .TX             ( TX_net_0 ),
        .common_const_o ( UART_interface_0_common_const_o ),
        .red_const_o    ( UART_interface_0_red_const_o ),
        .green_const_o  ( UART_interface_0_green_const_o ),
        .blue_const_o   ( UART_interface_0_blue_const_o ) 
        );


endmodule
