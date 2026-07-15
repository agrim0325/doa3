//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Aug  8 11:51:59 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// UART_interface
module UART_interface(
    // Inputs
    RX,
    reset_i,
    sys_clk_i,
    // Outputs
    TX,
    blue_const_o,
    common_const_o,
    green_const_o,
    red_const_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         RX;
input         reset_i;
input         sys_clk_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        TX;
output [9:0]  blue_const_o;
output [19:0] common_const_o;
output [9:0]  green_const_o;
output [9:0]  red_const_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [9:0]  blue_const_o_net_0;
wire   [19:0] common_const_o_net_0;
wire   [7:0]  COREUART_C0_0_DATA_OUT;
wire          COREUART_C0_0_RXRDY;
wire   [9:0]  green_const_o_net_0;
wire   [7:0]  receive_data_0_addr_o7to0;
wire   [31:0] receive_data_0_data_o;
wire          receive_data_0_data_rdy_o;
wire          receive_data_0_oen_o;
wire   [9:0]  red_const_o_net_0;
wire          reset_i;
wire          RX;
wire          sys_clk_i;
wire          TX_net_0;
wire          TX_net_1;
wire   [19:0] common_const_o_net_1;
wire   [9:0]  red_const_o_net_1;
wire   [9:0]  green_const_o_net_1;
wire   [9:0]  blue_const_o_net_1;
wire   [15:0] addr_o_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [12:0] BAUD_VAL_const_net_0;
wire   [7:0]  DATA_IN_const_net_0;
wire   [2:0]  BAUD_VAL_FRACTION_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                       = 1'b1;
assign GND_net                       = 1'b0;
assign BAUD_VAL_const_net_0          = 13'h001A;
assign DATA_IN_const_net_0           = 8'h00;
assign BAUD_VAL_FRACTION_const_net_0 = 3'h1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign TX_net_1             = TX_net_0;
assign TX                   = TX_net_1;
assign common_const_o_net_1 = common_const_o_net_0;
assign common_const_o[19:0] = common_const_o_net_1;
assign red_const_o_net_1    = red_const_o_net_0;
assign red_const_o[9:0]     = red_const_o_net_1;
assign green_const_o_net_1  = green_const_o_net_0;
assign green_const_o[9:0]   = green_const_o_net_1;
assign blue_const_o_net_1   = blue_const_o_net_0;
assign blue_const_o[9:0]    = blue_const_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign receive_data_0_addr_o7to0 = addr_o_net_0[7:0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------addr_decoder
addr_decoder addr_decoder_0(
        // Inputs
        .reset_i        ( reset_i ),
        .sys_clk_i      ( sys_clk_i ),
        .data_rdy_i     ( receive_data_0_data_rdy_o ),
        .addr_i         ( receive_data_0_addr_o7to0 ),
        .data_i         ( receive_data_0_data_o ),
        // Outputs
        .red_const_o    ( red_const_o_net_0 ),
        .green_const_o  ( green_const_o_net_0 ),
        .blue_const_o   ( blue_const_o_net_0 ),
        .common_const_o ( common_const_o_net_0 ) 
        );

//--------COREUART_C0
COREUART_C0 COREUART_C0_0(
        // Inputs
        .BIT8              ( VCC_net ),
        .CLK               ( sys_clk_i ),
        .CSN               ( GND_net ),
        .ODD_N_EVEN        ( GND_net ),
        .OEN               ( receive_data_0_oen_o ),
        .PARITY_EN         ( GND_net ),
        .RESET_N           ( reset_i ),
        .RX                ( RX ),
        .WEN               ( GND_net ),
        .BAUD_VAL          ( BAUD_VAL_const_net_0 ),
        .DATA_IN           ( DATA_IN_const_net_0 ),
        .BAUD_VAL_FRACTION ( BAUD_VAL_FRACTION_const_net_0 ),
        // Outputs
        .OVERFLOW          (  ),
        .PARITY_ERR        (  ),
        .RXRDY             ( COREUART_C0_0_RXRDY ),
        .TX                ( TX_net_0 ),
        .TXRDY             (  ),
        .FRAMING_ERR       (  ),
        .DATA_OUT          ( COREUART_C0_0_DATA_OUT ) 
        );

//--------receive_data
receive_data receive_data_0(
        // Inputs
        .reset_i    ( reset_i ),
        .sys_clk_i  ( sys_clk_i ),
        .rx_rdy_i   ( COREUART_C0_0_RXRDY ),
        .data_i     ( COREUART_C0_0_DATA_OUT ),
        // Outputs
        .oen_o      ( receive_data_0_oen_o ),
        .data_rdy_o ( receive_data_0_data_rdy_o ),
        .addr_o     ( addr_o_net_0 ),
        .data_o     ( receive_data_0_data_o ) 
        );


endmodule
