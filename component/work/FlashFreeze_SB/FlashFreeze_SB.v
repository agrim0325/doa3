//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Aug 23 12:06:59 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FlashFreeze_SB
module FlashFreeze_SB(
    // Inputs
    FAB_RESET_N,
    FF_Entry_SW,
    FIC_0_APB_M_PRDATA,
    FIC_0_APB_M_PREADY,
    FIC_0_APB_M_PSLVERR,
    POWER_ON_RESET_N,
    RCOSC_25_50MHZ,
    RCOSC_25_50MHZ_0,
    Wake_On_Change_SW,
    // Outputs
    FF_DONE,
    FF_TO_START,
    FIC_0_APB_M_PADDR,
    FIC_0_APB_M_PENABLE,
    FIC_0_APB_M_PSEL,
    FIC_0_APB_M_PWDATA,
    FIC_0_APB_M_PWRITE,
    GL0,
    GL1_XCLK,
    INIT_DONE,
    LOCK,
    SW_output,
    // Inouts
    SCL,
    SDA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         FAB_RESET_N;
input         FF_Entry_SW;
input  [31:0] FIC_0_APB_M_PRDATA;
input         FIC_0_APB_M_PREADY;
input         FIC_0_APB_M_PSLVERR;
input         POWER_ON_RESET_N;
input         RCOSC_25_50MHZ;
input         RCOSC_25_50MHZ_0;
input         Wake_On_Change_SW;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        FF_DONE;
output        FF_TO_START;
output [31:0] FIC_0_APB_M_PADDR;
output        FIC_0_APB_M_PENABLE;
output        FIC_0_APB_M_PSEL;
output [31:0] FIC_0_APB_M_PWDATA;
output        FIC_0_APB_M_PWRITE;
output        GL0;
output        GL1_XCLK;
output        INIT_DONE;
output        LOCK;
output        SW_output;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         SCL;
inout         SDA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          BIBUF_0_Y;
wire          BIBUF_1_Y;
wire          CCC_0_GL1;
wire          CORERESET_FF_0_0_RESET_N_F2M;
wire          FAB_RESET_N;
wire          FF_DONE_net_0;
wire          FF_Entry_SW;
wire          FF_TO_START_net_0;
wire   [31:0] FIC_0_APB_MASTER_PADDR;
wire          FIC_0_APB_MASTER_PENABLE;
wire   [31:0] FIC_0_APB_M_PRDATA;
wire          FIC_0_APB_M_PREADY;
wire          FIC_0_APB_MASTER_PSELx;
wire          FIC_0_APB_M_PSLVERR;
wire   [31:0] FIC_0_APB_MASTER_PWDATA;
wire          FIC_0_APB_MASTER_PWRITE;
wire          FlashFreeze_SB_MSS_0_FIC_2_APB_M_PRESET_N;
wire          FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F;
wire          FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F_OE;
wire          FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F;
wire          FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F_OE;
wire          FlashFreeze_SB_MSS_0_MSS_RESET_N_M2F;
wire          GL0_net_0;
wire          GL1_XCLK_0;
wire          INIT_DONE_0;
wire          LOCK_net_0;
wire          MX2_0_Y;
wire          POWER_ON_RESET_N;
wire          RCOSC_25_50MHZ_0;
wire          RCOSC_25_50MHZ;
wire          SCL;
wire          SDA;
wire          Wake_On_Change_SW;
wire          INIT_DONE_0_net_0;
wire          FF_DONE_net_1;
wire          GL1_XCLK_0_net_0;
wire          GL0_net_1;
wire          FIC_0_APB_MASTER_PSELx_net_0;
wire          FIC_0_APB_MASTER_PENABLE_net_0;
wire          FIC_0_APB_MASTER_PWRITE_net_0;
wire          Wake_On_Change_SW_net_0;
wire          FF_TO_START_net_1;
wire          LOCK_net_1;
wire   [31:0] FIC_0_APB_MASTER_PADDR_net_0;
wire   [31:0] FIC_0_APB_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [7:2]  PADDR_const_net_0;
wire   [7:0]  PWDATA_const_net_0;
wire   [31:0] FIC_2_APB_M_PRDATA_const_net_0;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire          PLL_ARST_N_IN_POST_INV0_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                        = 1'b1;
assign GND_net                        = 1'b0;
assign PADDR_const_net_0              = 6'h00;
assign PWDATA_const_net_0             = 8'h00;
assign FIC_2_APB_M_PRDATA_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign PLL_ARST_N_IN_POST_INV0_0 = ~ FF_DONE_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign INIT_DONE_0_net_0              = INIT_DONE_0;
assign INIT_DONE                      = INIT_DONE_0_net_0;
assign FF_DONE_net_1                  = FF_DONE_net_0;
assign FF_DONE                        = FF_DONE_net_1;
assign GL1_XCLK_0_net_0               = GL1_XCLK_0;
assign GL1_XCLK                       = GL1_XCLK_0_net_0;
assign GL0_net_1                      = GL0_net_0;
assign GL0                            = GL0_net_1;
assign FIC_0_APB_MASTER_PSELx_net_0   = FIC_0_APB_MASTER_PSELx;
assign FIC_0_APB_M_PSEL               = FIC_0_APB_MASTER_PSELx_net_0;
assign FIC_0_APB_MASTER_PENABLE_net_0 = FIC_0_APB_MASTER_PENABLE;
assign FIC_0_APB_M_PENABLE            = FIC_0_APB_MASTER_PENABLE_net_0;
assign FIC_0_APB_MASTER_PWRITE_net_0  = FIC_0_APB_MASTER_PWRITE;
assign FIC_0_APB_M_PWRITE             = FIC_0_APB_MASTER_PWRITE_net_0;
assign Wake_On_Change_SW_net_0        = Wake_On_Change_SW;
assign SW_output                      = Wake_On_Change_SW_net_0;
assign FF_TO_START_net_1              = FF_TO_START_net_0;
assign FF_TO_START                    = FF_TO_START_net_1;
assign LOCK_net_1                     = LOCK_net_0;
assign LOCK                           = LOCK_net_1;
assign FIC_0_APB_MASTER_PADDR_net_0   = FIC_0_APB_MASTER_PADDR;
assign FIC_0_APB_M_PADDR[31:0]        = FIC_0_APB_MASTER_PADDR_net_0;
assign FIC_0_APB_MASTER_PWDATA_net_0  = FIC_0_APB_MASTER_PWDATA;
assign FIC_0_APB_M_PWDATA[31:0]       = FIC_0_APB_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( CCC_0_GL1 ),
        .B ( MX2_0_Y ),
        // Outputs
        .Y ( GL1_XCLK_0 ) 
        );

//--------BIBUF
BIBUF BIBUF_0(
        // Inputs
        .D   ( FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F ),
        .E   ( FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F_OE ),
        // Outputs
        .Y   ( BIBUF_0_Y ),
        // Inouts
        .PAD ( SDA ) 
        );

//--------BIBUF
BIBUF BIBUF_1(
        // Inputs
        .D   ( FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F ),
        .E   ( FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F_OE ),
        // Outputs
        .Y   ( BIBUF_1_Y ),
        // Inouts
        .PAD ( SCL ) 
        );

//--------FlashFreeze_SB_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.201
FlashFreeze_SB_CCC_0_FCCC CCC_0(
        // Inputs
        .RCOSC_25_50MHZ  ( RCOSC_25_50MHZ ),
        .PLL_ARST_N      ( PLL_ARST_N_IN_POST_INV0_0 ),
        .PLL_POWERDOWN_N ( VCC_net ),
        // Outputs
        .GL0             ( GL0_net_0 ),
        .GL1             ( CCC_0_GL1 ),
        .LOCK            ( LOCK_net_0 ) 
        );

//--------CORERESET_FF_0
CORERESET_FF_0 CORERESET_FF_0_0(
        // Inputs
        .CLK_BASE             ( GL0_net_0 ),
        .CONFIG1_DONE         ( VCC_net ),
        .CONFIG2_DONE         ( VCC_net ),
        .FAB_RESET_N          ( FAB_RESET_N ),
        .FF_DONE              ( FF_DONE_net_0 ),
        .FIC_2_APB_M_PRESET_N ( FlashFreeze_SB_MSS_0_FIC_2_APB_M_PRESET_N ),
        .POWER_ON_RESET_N     ( POWER_ON_RESET_N ),
        .RCOSC_25_50MHZ       ( RCOSC_25_50MHZ_0 ),
        .RESET_N_M2F          ( FlashFreeze_SB_MSS_0_MSS_RESET_N_M2F ),
        // Outputs
        .INIT_DONE            ( INIT_DONE_0 ),
        .M3_RESET_N           (  ),
        .MSS_HPMS_READY       (  ),
        .RESET_N_F2M          ( CORERESET_FF_0_0_RESET_N_F2M ) 
        );

//--------FLASH_FREEZE
FLASH_FREEZE FLASH_FREEZE_0(
        // Outputs
        .FF_TO_START ( FF_TO_START_net_0 ),
        .FF_DONE     ( FF_DONE_net_0 ) 
        );

//--------FlashFreeze_SB_MSS
FlashFreeze_SB_MSS FlashFreeze_SB_MSS_0(
        // Inputs
        .MCCC_CLK_BASE          ( GL0_net_0 ),
        .MCCC_CLK_BASE_PLL_LOCK ( MX2_0_Y ),
        .MSS_RESET_N_F2M        ( CORERESET_FF_0_0_RESET_N_F2M ),
        .GPIO_0_F2M             ( GND_net ),
        .FIC_2_APB_M_PREADY     ( VCC_net ), // tied to 1'b1 from definition
        .FIC_2_APB_M_PSLVERR    ( GND_net ), // tied to 1'b0 from definition
        .GPIO_1_F2M             ( FF_Entry_SW ),
        .FIC_0_APB_M_PREADY     ( FIC_0_APB_M_PREADY ),
        .FIC_0_APB_M_PSLVERR    ( FIC_0_APB_M_PSLVERR ),
        .I2C_0_SDA_F2M          ( BIBUF_0_Y ),
        .I2C_0_SCL_F2M          ( BIBUF_1_Y ),
        .FIC_2_APB_M_PRDATA     ( FIC_2_APB_M_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .FIC_0_APB_M_PRDATA     ( FIC_0_APB_M_PRDATA ),
        // Outputs
        .MSS_RESET_N_M2F        ( FlashFreeze_SB_MSS_0_MSS_RESET_N_M2F ),
        .FIC_2_APB_M_PRESET_N   ( FlashFreeze_SB_MSS_0_FIC_2_APB_M_PRESET_N ),
        .FIC_2_APB_M_PCLK       (  ),
        .FIC_2_APB_M_PWRITE     (  ),
        .FIC_2_APB_M_PENABLE    (  ),
        .FIC_2_APB_M_PSEL       (  ),
        .FIC_0_APB_M_PSEL       ( FIC_0_APB_MASTER_PSELx ),
        .FIC_0_APB_M_PWRITE     ( FIC_0_APB_MASTER_PWRITE ),
        .FIC_0_APB_M_PENABLE    ( FIC_0_APB_MASTER_PENABLE ),
        .I2C_0_SDA_M2F          ( FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F ),
        .I2C_0_SDA_M2F_OE       ( FlashFreeze_SB_MSS_0_I2C_0_SDA_M2F_OE ),
        .I2C_0_SCL_M2F          ( FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F ),
        .I2C_0_SCL_M2F_OE       ( FlashFreeze_SB_MSS_0_I2C_0_SCL_M2F_OE ),
        .FIC_2_APB_M_PADDR      (  ),
        .FIC_2_APB_M_PWDATA     (  ),
        .FIC_0_APB_M_PADDR      ( FIC_0_APB_MASTER_PADDR ),
        .FIC_0_APB_M_PWDATA     ( FIC_0_APB_MASTER_PWDATA ) 
        );

//--------MX2
MX2 MX2_0(
        // Inputs
        .A ( LOCK_net_0 ),
        .B ( VCC_net ),
        .S ( FF_DONE_net_0 ),
        // Outputs
        .Y ( MX2_0_Y ) 
        );


endmodule
