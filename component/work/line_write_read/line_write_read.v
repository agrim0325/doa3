//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Aug  8 15:47:52 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// line_write_read
module line_write_read(
    // Inputs
    B_CONST_I,
    COMMON_CONST_I,
    DATA_I,
    G_CONST_I,
    H_REF_I,
    PCLK_I,
    RESETN_I,
    R_CONST_I,
    SYS_CLK_I,
    V_SYNC_I,
    init_done_i,
    // Outputs
    cs_o,
    data_o,
    dc_o,
    lcd_wr_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [9:0]  B_CONST_I;
input  [19:0] COMMON_CONST_I;
input  [7:0]  DATA_I;
input  [9:0]  G_CONST_I;
input         H_REF_I;
input         PCLK_I;
input         RESETN_I;
input  [9:0]  R_CONST_I;
input         SYS_CLK_I;
input         V_SYNC_I;
input         init_done_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        cs_o;
output [7:0]  data_o;
output        dc_o;
output        lcd_wr_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [9:0]   B_CONST_I;
wire   [19:0]  COMMON_CONST_I;
wire           cs_o_net_0;
wire   [7:0]   DATA_I;
wire   [7:0]   data_o_net_0;
wire           dc_o_net_0;
wire   [7:0]   double_sync_0_DATA_O;
wire           double_sync_0_HREF_O;
wire           double_sync_0_PCLK_O;
wire   [9:0]   G_CONST_I;
wire           H_REF_I;
wire   [7:3]   Image_Enhancement_0_DATA_O7to3;
wire   [15:10] Image_Enhancement_0_DATA_O15to10;
wire   [23:19] Image_Enhancement_0_DATA_O23to19;
wire           Image_Enhancement_0_DATA_VALID_O;
wire   [9:0]   Image_Enhancement_0_RAM_ADDR_O;
wire           init_done_i;
wire   [9:0]   LCD_FSM_0_ram_addr_o;
wire           LCD_FSM_0_ram_read_en_o;
wire           lcd_wr_o_net_0;
wire           PCLK_I;
wire   [9:0]   R_CONST_I;
wire   [15:0]  ramDualPort_0_q_b;
wire           RESETN_I;
wire           SYS_CLK_I;
wire           V_SYNC_I;
wire   [4:0]   WRITE_LSRAM_0_DATA_O4to0;
wire   [10:5]  WRITE_LSRAM_0_DATA_O10to5;
wire   [15:11] WRITE_LSRAM_0_DATA_O15to11;
wire   [9:0]   WRITE_LSRAM_0_RAM_ADDRESS_O;
wire           WRITE_LSRAM_0_RAM_WR_EN_O;
wire           dc_o_net_1;
wire           cs_o_net_1;
wire           lcd_wr_o_net_1;
wire   [7:0]   data_o_net_1;
wire   [18:16] DATA_O_slice_0;
wire   [2:0]   DATA_O_slice_1;
wire   [9:8]   DATA_O_slice_2;
wire   [23:0]  DATA_I_net_0;
wire   [23:0]  DATA_O_net_2;
wire   [15:0]  data_a_net_0;
wire   [15:0]  DATA_O_net_3;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire           VCC_net;
wire   [18:16] DATA_I_const_net_0;
wire   [2:0]   DATA_I_const_net_1;
wire   [9:8]   DATA_I_const_net_2;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net            = 1'b1;
assign DATA_I_const_net_0 = 3'h0;
assign DATA_I_const_net_1 = 3'h0;
assign DATA_I_const_net_2 = 2'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign dc_o_net_1     = dc_o_net_0;
assign dc_o           = dc_o_net_1;
assign cs_o_net_1     = cs_o_net_0;
assign cs_o           = cs_o_net_1;
assign lcd_wr_o_net_1 = lcd_wr_o_net_0;
assign lcd_wr_o       = lcd_wr_o_net_1;
assign data_o_net_1   = data_o_net_0;
assign data_o[7:0]    = data_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign Image_Enhancement_0_DATA_O7to3   = DATA_O_net_2[7:3];
assign Image_Enhancement_0_DATA_O15to10 = DATA_O_net_2[15:10];
assign Image_Enhancement_0_DATA_O23to19 = DATA_O_net_2[23:19];
assign WRITE_LSRAM_0_DATA_O4to0         = DATA_O_net_3[4:0];
assign WRITE_LSRAM_0_DATA_O10to5        = DATA_O_net_3[10:5];
assign WRITE_LSRAM_0_DATA_O15to11       = DATA_O_net_3[15:11];
assign DATA_O_slice_0                   = DATA_O_net_2[18:16];
assign DATA_O_slice_1                   = DATA_O_net_2[2:0];
assign DATA_O_slice_2                   = DATA_O_net_2[9:8];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign DATA_I_net_0 = { WRITE_LSRAM_0_DATA_O15to11 , 3'h0 , WRITE_LSRAM_0_DATA_O10to5 , 2'h0 , WRITE_LSRAM_0_DATA_O4to0 , 3'h0 };
assign data_a_net_0 = { Image_Enhancement_0_DATA_O23to19 , Image_Enhancement_0_DATA_O15to10 , Image_Enhancement_0_DATA_O7to3 };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------double_flop
double_flop double_flop_0(
        // Inputs
        .RESETN_I  ( RESETN_I ),
        .SYS_CLK_I ( SYS_CLK_I ),
        .PCLK_I    ( PCLK_I ),
        .DATA_I    ( DATA_I ),
        .HREF_I    ( H_REF_I ),
        // Outputs
        .PCLK_O    ( double_sync_0_PCLK_O ),
        .DATA_O    ( double_sync_0_DATA_O ),
        .HREF_O    ( double_sync_0_HREF_O ) 
        );

//--------Image_Enhancement
Image_Enhancement Image_Enhancement_0(
        // Inputs
        .RESETN_I       ( RESETN_I ),
        .SYS_CLK_I      ( SYS_CLK_I ),
        .DATA_VALID_I   ( WRITE_LSRAM_0_RAM_WR_EN_O ),
        .ENABLE_I       ( VCC_net ),
        .DATA_I         ( DATA_I_net_0 ),
        .RAM_ADDR_I     ( WRITE_LSRAM_0_RAM_ADDRESS_O ),
        .R_CONST_I      ( R_CONST_I ),
        .G_CONST_I      ( G_CONST_I ),
        .B_CONST_I      ( B_CONST_I ),
        .COMMON_CONST_I ( COMMON_CONST_I ),
        // Outputs
        .DATA_VALID_O   ( Image_Enhancement_0_DATA_VALID_O ),
        .RAM_ADDR_O     ( Image_Enhancement_0_RAM_ADDR_O ),
        .DATA_O         ( DATA_O_net_2 ) 
        );

//--------LCD_FSM
LCD_FSM LCD_FSM_0(
        // Inputs
        .sys_clk_i        ( SYS_CLK_I ),
        .reset_i          ( RESETN_I ),
        .init_done_i      ( init_done_i ),
        .v_sync_i         ( V_SYNC_I ),
        .RAM_WRITE_ADDR_I ( Image_Enhancement_0_RAM_ADDR_O ),
        .ram_data_i       ( ramDualPort_0_q_b ),
        // Outputs
        .lcd_wr_o         ( lcd_wr_o_net_0 ),
        .cs_o             ( cs_o_net_0 ),
        .dc_o             ( dc_o_net_0 ),
        .ram_read_en_o    ( LCD_FSM_0_ram_read_en_o ),
        .ram_addr_o       ( LCD_FSM_0_ram_addr_o ),
        .data_o           ( data_o_net_0 ) 
        );

//--------ramDualPort
ramDualPort ramDualPort_0(
        // Inputs
        .clk    ( SYS_CLK_I ),
        .we_a   ( Image_Enhancement_0_DATA_VALID_O ),
        .we_b   ( LCD_FSM_0_ram_read_en_o ),
        .addr_a ( Image_Enhancement_0_RAM_ADDR_O ),
        .addr_b ( LCD_FSM_0_ram_addr_o ),
        .data_a ( data_a_net_0 ),
        // Outputs
        .q_b    ( ramDualPort_0_q_b ) 
        );

//--------WRITE_LSRAM
WRITE_LSRAM WRITE_LSRAM_0(
        // Inputs
        .RESETN_I      ( RESETN_I ),
        .SYS_CLK_I     ( SYS_CLK_I ),
        .PCLK_I        ( double_sync_0_PCLK_O ),
        .H_REF_I       ( double_sync_0_HREF_O ),
        .V_SYNC_I      ( V_SYNC_I ),
        .DATA_I        ( double_sync_0_DATA_O ),
        // Outputs
        .RAM_WR_EN_O   ( WRITE_LSRAM_0_RAM_WR_EN_O ),
        .DATA_O        ( DATA_O_net_3 ),
        .RAM_ADDRESS_O ( WRITE_LSRAM_0_RAM_ADDRESS_O ) 
        );


endmodule
