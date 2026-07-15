// ********************************************************************/
// Actel Corporation Proprietary and Confidential
//  Copyright 2008 Actel Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description:  CoreFIR7.0
//               This module contains small modules like delay and fabric RAM
//
// Revision Information:
// Date     Description
// 21Oct10 Initial Release
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// *********************************************************************/

`timescale 1 ns/100 ps

// ----------- Simple one-DFF Edge Detector ------------
module decm_kitEdge (nGrst, rst, clk, inp, outp);
  parameter REDGE = 1;   // 1 - rising edge, or 0 - falling edge

  input  nGrst, clk, rst;
  input inp;
  output outp;

  reg inp_tick;
  wire rise_edge, fall_edge;

  assign rise_edge = inp & ~inp_tick;
  assign fall_edge = ~inp & inp_tick;
  assign    outp      = (REDGE) ? rise_edge : fall_edge;

  always @(posedge clk or negedge nGrst) begin
    if(!nGrst)    inp_tick <= 1'b0;
    else
      if (rst)    inp_tick <= 1'b0;
      else        inp_tick <= inp;

  end
endmodule
/*  -- usage
 decm_kitEdge # (.REDGE(1)) edge_detect_0 (
     .nGrst(nGrst), .rst(rst), .clk(clk),
     .inp(in), .outp(out) );
*/
// -----------------------------------------------------------------------------
//    ########    ########   ##           ###     ##    ##
//    ##     ##   ##         ##          ## ##     ##  ##
//    ##     ##   ##         ##         ##   ##     ####
//    ##     ##   ######     ##        ##     ##     ##
//    ##     ##   ##         ##        #########     ##
//    ##     ##   ##         ##        ##     ##     ##
//    ########    ########   ########  ##     ##     ##


//----------- Register-based 1-bit Delay has only input and output ---------
//

module decm_kitDelay_bit_reg(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  inp;
  output outp;
  // extra register to avoid error if DELAY==0
  reg delayLine [0:DELAY-1];
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)      delayLine[i] <= 1'b0;
        else
          if (rst)
            for (i = 0; i<DELAY; i=i+1) delayLine[i] <= 1'b0;
          else
            if (clkEn) begin
              for(i=DELAY-1; i>=1; i=i-1)
                 delayLine[i] <= delayLine[i-1];

              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/* Use
  decm_kitDelay_bit_reg # (.DELAY(2)) bit_dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .inp(input), .outp(outp) ) ;
*/

module decm_kitDelay_reg(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    BITWIDTH = 16,
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  [BITWIDTH-1:0] inp;
  output   [BITWIDTH-1:0] outp;
  // extra register to avoid error if DELAY==0
  reg [BITWIDTH-1:0] delayLine [0:DELAY];
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)         delayLine[i] <= 'b0;
        else
          if (clkEn)
            if (rst)
              for (i = 0; i<DELAY; i=i+1)  delayLine[i] <= 'b0;
            else begin
              for(i=DELAY-1; i>=1; i=i-1)  delayLine[i] <= delayLine[i-1];
              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/* Use
  decm_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(1) ) dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .inp(datain), .outp(dataout)  );
*/

//     #####
//    #     #   ####   #    #  #    #  #####  ######  #####
//    #        #    #  #    #  ##   #    #    #       #    #
//    #        #    #  #    #  # #  #    #    #####   #    #
//    #        #    #  #    #  #  # #    #    #       #####
//    #     #  #    #  #    #  #   ##    #    #       #   #
//     #####    ####    ####   #    #    #    ######  #    #

// simple incremental counter
module decm_kitCountS(nGrst, rst, clk, clkEn, cntEn, Q, dc);
  parameter WIDTH = 16;
  parameter DCVALUE = (1 << WIDTH) - 1; // state to decode
  parameter BUILD_DC = 1;

  input nGrst, rst, clk, clkEn, cntEn;
  output [WIDTH-1:0] Q;
  output dc;  // decoder output
  reg [WIDTH-1:0] Q;

  assign #1 dc = (BUILD_DC==1)? (Q == DCVALUE) : 1'bx;

  always@(negedge nGrst or posedge clk)
    if(!nGrst) Q <= {WIDTH{1'b0}};
    else
      if(clkEn)
        if(rst)       Q <= {WIDTH{1'b0}};
        else
          if(cntEn)   Q <= Q + 1'b1;
endmodule
/* instance
  decm_kitCountS # ( .WIDTH(WIDTH), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .cntEn(cntEn), .Q(outp), .dc() );
*/

//complex counter
//module decm_kitCountC(nGrst, rst, clk, clkEn, cntEn, up, ld, din, Q, dc);
//  parameter WIDTH = 16;     // in bits
//  parameter UPDOWN = 2;  // 0 - up, 1-down, 2 - up/down
//  parameter DCVALUE = (1 << WIDTH) - 1; // state to decode
//  parameter BUILD_CLKEN = 1;
//  parameter BUILD_RST = 1;
//  parameter BUILD_LD = 1;
//  parameter BUILD_DC = 1;
//
//  input nGrst, rst, clk, clkEn, cntEn, up, ld;
//  input [WIDTH-1:0] din;
//  output [WIDTH-1:0] Q;
//  output dc;  // decoder output
//  reg [WIDTH-1:0] Q;
//
//  assign dc = (BUILD_DC==1)? (Q == DCVALUE) : 1'bx;
//
//  always@(negedge nGrst or posedge clk) begin
//    if(!nGrst) Q <= {WIDTH{1'b0}};
//    else
//      if(clkEn || (BUILD_CLKEN==0) ) begin // if clkEn, or no clkEn input at all
//        if(rst && BUILD_RST) Q <= {WIDTH{1'b0}};
//        else begin
//          if(ld && BUILD_LD)  Q <= din; // sync load
//          else
//            if(cntEn) begin  // regular count
//              if(UPDOWN==0)           Q <= Q + 1'b1;
//              if(UPDOWN==1)           Q <= Q - 1'b1;
//              if((UPDOWN==2) && up)   Q <= Q + 1'b1;
//              if((UPDOWN==2) && !up)  Q <= Q - 1'b1;
//            end // count
//        end
//      end
//  end // always
//endmodule

/* instance
  decm_kitCountC # ( .WIDTH(WIDTH), .UPDOWN(0), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_CLKEN(1), .BUILD_RST(1), .BUILD_LD(0),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn), .cntEn(cntEn),
    .up(1'bx), .ld(1'bx), .din({WIDTH{1'bx}}), .Q(outp), .dc() );
*/


//         ####  #  ####  #    #    ###### #    # ##### ###### #    # #####
//        #      # #    # ##   #    #       #  #    #   #      ##   # #    #
//         ####  # #      # #  #    #####    ##     #   #####  # #  # #    #
//             # # #  ### #  # #    #        ##     #   #      #  # # #    #
//        #    # # #    # #   ##    #       #  #    #   #      #   ## #    #
//         ####  #  ####  #    #    ###### #    #   #   ###### #    # #####

// Result: Resizes the vector inp to the specified size.
// To create a larger vector, the new [leftmost] bit positions are filled
// with the sign bit (if UNSIGNED==0) or 0's (if UNSIGNED==1).
// When truncating, the sign bit is retained along with the rightmost part
// if UNSIGNED==0.  Otherwise (UNSIGNED==1) the leftmost bits are all dropped.
module decm_signExt (inp, outp);
  parameter INWIDTH = 16;
  parameter OUTWIDTH = 20;
  parameter UNSIGNED = 0;   // 0-signed conversion; 1-unsigned

  input [INWIDTH-1:0] inp;
  output[OUTWIDTH-1:0] outp;

  generate
    if(INWIDTH >= OUTWIDTH) begin: sign_trunc_inp
      assign outp[OUTWIDTH-1] = UNSIGNED ? inp[OUTWIDTH-1] : inp[INWIDTH-1];
      assign outp[OUTWIDTH-2:0] = inp[OUTWIDTH-2:0];
    end
  endgenerate

  generate
    if(INWIDTH < OUTWIDTH) begin: sign_ext_inp
      assign outp = UNSIGNED ?  {{(OUTWIDTH-INWIDTH){1'b0}}, inp} :
                                {{(OUTWIDTH-INWIDTH){inp[INWIDTH-1]}}, inp};
    end
  endgenerate
endmodule
/* usage:
  decm_signExt # ( .INWIDTH(DATA_WIDTH),
              .OUTWIDTH(DATA_WIDTH_MAC),
              .UNSIGNED(UNSIGNED)) decm_signExt_0 (
    .inp(data), .outp(data2mac)   );
*/

//                     ########      ###     ##     ##
//                     ##     ##    ## ##    ###   ###
//                     ##     ##   ##   ##   #### ####
//                     ########   ##     ##  ## ### ##
//                     ##   ##    #########  ##     ##
//                     ##    ##   ##     ##  ##     ##
//                     ##     ##  ##     ##  ##     ##
//
// --------- Two-port RAM simulation model ----------
// It has an extra reg simulating an output hard RAM register
module decm_RAM_fabric (nGrst, RCLOCK, WCLOCK,
       WRB, RDB,
       DI,
       RADDR, WADDR,
       DO       );
  parameter
    BITWIDTH     = 16,
    RAM_LOGDEPTH = 8,
    RAM_DEPTH = 1256;

  input  nGrst, WCLOCK, RCLOCK;
  input  WRB, RDB;
  input  [BITWIDTH-1:0] DI;
  input  [RAM_LOGDEPTH-1:0] RADDR, WADDR;
  output [BITWIDTH-1:0] DO;

  reg [BITWIDTH-1:0] ramArray [0:RAM_DEPTH-1] /* synthesis syn_ramstyle="registers" */;
  reg [BITWIDTH-1:0] arrOut;
  integer i;

  assign DO = arrOut;
  // write
  always @(posedge WCLOCK or negedge nGrst)
    if(!nGrst)
      for(i=0; i<RAM_DEPTH; i=i+1)
        ramArray[i] <= 'bx;
    else
      if (WRB) ramArray[WADDR] <= DI;

  // read
  always @(posedge RCLOCK)                // RAM block output register
    if (RDB) arrOut <= ramArray[RADDR];

endmodule


//                  +-+-+-+-+-+-+-+-+-+-+-+
//                  |A|c|c|u|m|u|l|a|t|o|r|
//                  +-+-+-+-+-+-+-+-+-+-+-+

module fabric_accumulator (nGrst, clk, rst, D, Q, clkEn);
  parameter BITWIDTH = 16;

  input clk, rst, nGrst, clkEn;
  input  [BITWIDTH-1:0] D;
  output [BITWIDTH-1:0] Q;

  reg    [BITWIDTH-1:0] Q;

  always @(posedge clk or negedge nGrst )
    if(nGrst==1'b0)
      Q <= 'b0;
    else
      if(clkEn)
        if (rst)
          Q <= D;
        else
          Q <= Q + D;
endmodule



//rt
// Asynchronous global reset synchronizer generates 
//  1. A 1 or 2-clk wide sync'ed pulse on rear (rising) edge of the async reset
//  2. A copy of nGrst (synced_ngrst) with synced rear (rising) edge.  The 
//     synced_ngrst starts asynchronously but ends sync'd to clk
module decm_kitSync_ngrst (nGrst, clk, pulse, synced_ngrst);
  parameter PULSE_WIDTH = 1;
  
  input nGrst, clk;
  output pulse, synced_ngrst;
  
  reg pulse; 
  reg tick1, tick2;
  wire pulsei;

  // Synchronize nGrst
  decm_kitDelay_bit_reg # (.DELAY(4)) sync_ngrst_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(1'b1), .outp(synced_ngrst) ) ;
  
  always @ (posedge clk)
    tick1 <= synced_ngrst;

  generate if (PULSE_WIDTH==2) 
    begin: two_clk
      always @ (posedge clk)
        tick2 <= tick1;
    
      assign pulsei = synced_ngrst & ~tick2;    
    end
  endgenerate
  
  generate if (PULSE_WIDTH!=2) 
    begin: one_clk
      assign pulsei = synced_ngrst & ~tick1;    
    end
  endgenerate
  
  always @ (posedge clk)
    pulse <= pulsei;

endmodule  
//rt ends



module write_reload_coef_intrp (nGrst, rst, clk, wClk,
  refresh,      // in: start writing (inititalizing) const coefficients
  refresh_done, // out: writing is complete
  rd_page,      // in: which page to read
  // Reloadable mode inputs
  coefi, coefi_valid,
  // Interface to tap coef storages
  tap_select,   // out: which tap to initialize
  wA,           // out: write address
  wCoef,         // out: coefficient to be written in a RAM
  wEn );        // out: write mode
  parameter COEF_WIDTH    = 18;
  parameter INTRP_FACTOR   = 4;
  parameter LOG_INTRP_FACTOR = 2;
  parameter PAGE          = 1;
  parameter TAPS          = 5;
  parameter TAPS_PHY      = 5;
  parameter COEF_SETS     = 4;

  localparam LOG_COEF_ROM_DEPTH = LOG_INTRP_FACTOR+PAGE;

  input clk, nGrst, rst, refresh, rd_page, coefi_valid;
  input [COEF_WIDTH-1:0] coefi;
  output [COEF_WIDTH-1:0] wCoef;
  output refresh_done, wEn, wClk;
  output [LOG_COEF_ROM_DEPTH-1:0] wA;
  output [TAPS_PHY-1:0] tap_select;   // one-hot register

  reg wEn;
  reg [LOG_COEF_ROM_DEPTH-1:0] wA;
  reg [TAPS_PHY-1:0] tap_selecti;
  wire [TAPS_PHY-1:0] last_tap_const;
  wire [LOG_COEF_ROM_DEPTH-1:0] init_wA;
  wire synced_ngrst;                                              //rt

  // const 1000...00.  Points to the last phy tap
  assign last_tap_const = 'b1 << (TAPS_PHY-1);
  assign wClk = clk;

  // Generate wA, and tap_selecti.  Coefficients are located in the tap RAM's in
  // the following order (16 taps, decim factor 4 is shown):
  //      |     tap
  //  wA  | 0     1     2     3
  //  ---------------------------
  //   0  | c3    c7    c11   c15
  //   1  | c2    c6    c10   c14
  //   2  | c1    c5    c9    c13
  //   3  | c0    c4    c8    c12
  // To achieve the above location at natural order of the incoming coefficients,
  // the wA is straight
  // Initialize wA counter on refresh signal
  generate
    if(PAGE == 0) begin: one_page_init
      assign init_wA = 'b0;
    end
    else  begin: two_page_init
      assign init_wA = (rd_page == 1'b1) ? 'b0 : INTRP_FACTOR;
    end
  endgenerate

  // generate synced_ngrst with rear end sync'd to clk                      //rt
  decm_kitSync_ngrst # (.PULSE_WIDTH(1)) synced_ngrst_gen_0 (               //rt
    .nGrst(nGrst), .clk(clk), .pulse(),                                     //rt
    .synced_ngrst(synced_ngrst) );                                          //rt

  always @(posedge clk)       //rt or negedge nGrst )
//rt    if (nGrst==1'b0) begin               
//rt      wA          <= 'b0;                           
//rt      tap_selecti <= 'b1;
//rt 	  end      
//rt 	  else 
 	  if( (rst==1'b1)||(refresh==1'b1)||(synced_ngrst==1'b0) )  begin         //rt
      wA          <= init_wA;
      tap_selecti <= 'b1;
    end 
    else 
      if(coefi_valid) 
        if( (wA == INTRP_FACTOR-1) || (wA == 2*INTRP_FACTOR-1) ) begin
          wA  <= init_wA;
          tap_selecti <= tap_selecti<<1;
        end
        else
          wA  <= wA + 1;

  // Generate write mode signal
  always @(posedge clk or negedge nGrst )
    if (nGrst==1'b0)   wEn <= 1'b1;
    else
 	    if( (rst==1'b1)||(refresh==1'b1) )  wEn <= 1'b1;    
      else  
        // keep wEn active until full wA cycle is over for one- & two-page cases
        if( (tap_selecti==last_tap_const) && ( 
            (wA == INTRP_FACTOR-1) || (wA == 2*INTRP_FACTOR-1) ) ) 
          wEn <= 1'b0;

  assign tap_select = (wEn==1'b1) ? tap_selecti : {TAPS_PHY{1'b0}};

  // Generate refresh_done as a rear edge of the wEn
  decm_kitEdge # (.REDGE(0)) edge_detect_0 (
      .nGrst(nGrst), .rst(rst), .clk(clk),
      .inp(wEn),
      .outp(refresh_done) );

  assign wCoef = coefi;
endmodule




module write_reload_coef_decm (nGrst, rst, clk, wClk,
  refresh,      // in: start writing (inititalizing) const coefficients
  refresh_done, // out: writing is complete
  rd_page,      // in: which page to read
  // Reloadable mode inputs
  coefi, coefi_valid,
  // Interface to tap coef storages
  tap_select,   // out: which tap to initialize
  wA,           // out: write address
  wCoef,         // out: coefficient to be written in a RAM
  wEn );        // out: write mode
  parameter COEF_WIDTH    = 18;
  parameter DECM_FACTOR   = 4;
  parameter LOG_DECM_FACTOR = 2;
  parameter PAGE          = 1;
  parameter TAPS          = 5;
  parameter TAPS_PHY      = 5;
  parameter COEF_SETS     = 4;

  localparam LOG_COEF_ROM_DEPTH = LOG_DECM_FACTOR+PAGE;

  input clk, nGrst, rst, refresh, rd_page, coefi_valid;
  input [COEF_WIDTH-1:0] coefi;
  output [COEF_WIDTH-1:0] wCoef;
  output refresh_done, wEn, wClk;
  output [LOG_COEF_ROM_DEPTH-1:0] wA;
  output [TAPS_PHY-1:0] tap_select;   // one-hot register

  reg wEn;
  reg [LOG_COEF_ROM_DEPTH-1:0] wA;
  reg [TAPS_PHY-1:0] tap_selecti;
  wire [TAPS_PHY-1:0] last_tap_const;
  wire [LOG_COEF_ROM_DEPTH-1:0] init_wA;
  wire synced_ngrst;                                              //rt

  // const 1000...00.  Points to the last phy tap
  assign last_tap_const = 'b1 << (TAPS_PHY-1);
  assign wClk = clk;

  // Generate wA, and tap_selecti.  Coefficients are located in the tap RAM's in
  // the following order (16 taps, decim factor 4 is shown):
  //      |     tap
  //  wA  | 0     1     2     3
  //  ---------------------------
  //   0  | c3    c7    c11   c15
  //   1  | c2    c6    c10   c14
  //   2  | c1    c5    c9    c13
  //   3  | c0    c4    c8    c12
  // To achieve the above location at natural order of the incoming coefficients,
  // the wA is straight ascending

  generate
    if(PAGE == 0) begin: one_page_init
      assign init_wA = 'b0;
    end
    else  begin: two_page_init
      assign init_wA = (rd_page == 1'b1) ? 'b0 : DECM_FACTOR;
    end
  endgenerate

  // generate synced_ngrst with rear end sync'd to clk                      //rt
  decm_kitSync_ngrst # (.PULSE_WIDTH(1)) synced_ngrst_gen_0 (               //rt
    .nGrst(nGrst), .clk(clk), .pulse(),                                     //rt
    .synced_ngrst(synced_ngrst) );                                          //rt

  always @(posedge clk)       //rt or negedge nGrst )
//rt    if (nGrst==1'b0) begin               
//rt      wA          <= 'b0;                           
//rt      tap_selecti <= 'b1;
//rt 	  end      
//rt 	  else 
 	  if( (rst==1'b1)||(refresh==1'b1)||(synced_ngrst==1'b0) )  begin       //rt
      wA          <= init_wA;
      tap_selecti <= 'b1;
    end 
    else 
      if(coefi_valid==1'b1)
        if( (wA == DECM_FACTOR-1) || (wA == 2*DECM_FACTOR-1) ) begin
          wA  <= init_wA;
          tap_selecti <= tap_selecti<<1;
        end
        else
          wA  <= wA + 1;


  // Generate write mode signal
  always @(posedge clk or negedge nGrst )
    if (nGrst==1'b0)   wEn <= 1'b1;
    else
 	    if( (rst==1'b1)||(refresh==1'b1) )  wEn <= 1'b1;    
      else  
        // keep wEn active until full wA cycle is over for one- & two-page cases
        if( (tap_selecti==last_tap_const) && ( 
            (wA == DECM_FACTOR-1) || (wA == 2*DECM_FACTOR-1) ) ) 
          wEn <= 1'b0;

  assign tap_select = (wEn==1'b1) ? tap_selecti : {TAPS_PHY{1'b0}};

  // Generate refresh_done as a rear edge of the wEn
  decm_kitEdge # (.REDGE(0)) edge_detect_0 (
      .nGrst(nGrst), .rst(rst), .clk(clk),
      .inp(wEn),
      .outp(refresh_done) );

  assign wCoef = coefi;
endmodule



//         ######                                #
//         #     # ###### #        ##   #   #    #       # #    # ######
//         #     # #      #       #  #   # #     #       # ##   # #
//         #     # #####  #      #    #   #      #       # # #  # #####
//         #     # #      #      ######   #      #       # #  # # #
//         #     # #      #      #    #   #      #       # #   ## #
//         ######  ###### ###### #    #   #      ####### # #    # ######

module intrp_data_dly_section (nGrst, rst, clk, rclk,
                                        validi, valido, datai, datao);
  parameter
    BITWIDTH  = 16,
    FPGA_FAMILY = 19,
    XREG      = 3,    // additional delay if the last MAC before chain break
    CHAIN_BREAK = 0;  // increase the delay by XREG

  input nGrst, rst, clk, validi, rclk;
  input  [BITWIDTH-1:0] datai;
  output [BITWIDTH-1:0] datao;
  output valido;

  wire [BITWIDTH-1:0] data_shft, datai_cross;
  wire valid_shft, validi_cross, validi_cross_slim;

  generate
    if( CHAIN_BREAK==1 )
      begin: inter_row_pipes
        decm_kitDelay_reg # (.BITWIDTH(BITWIDTH), .DELAY(XREG)) data_pipe_0 (
          .nGrst(nGrst), .clk(clk), .clkEn(rclk), .rst(rst),
          .inp(datai), .outp(datai_cross)  );

        decm_kitDelay_bit_reg # (.DELAY(XREG)) valid_pipe_0 (
          .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(rclk),
          .inp(validi),
          .outp(validi_cross) ) ;
      end
    else begin: no_break
      assign datai_cross  = datai;
      assign validi_cross = validi;
    end
  endgenerate

  assign validi_cross_slim = validi_cross & rclk;
  assign valido_slim = valido & rclk;

  decm_kitDelay_reg # (.BITWIDTH(BITWIDTH), .DELAY(1)) inter_datai_valid_dly_0 (
        .nGrst(nGrst), .clk(clk), .clkEn(validi_cross_slim), .rst(rst),
        .inp(datai_cross), .outp(data_shft)  );

  decm_kitDelay_bit_reg # (.DELAY(1)) rclk_valid_dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(rclk),
    .inp(validi_cross),
    .outp(valido) ) ;

  decm_kitDelay_reg # (.BITWIDTH(BITWIDTH), .DELAY(1)) rclk_data_dly_0 (
        .nGrst(nGrst), .clk(clk), .clkEn(valido_slim), .rst(rst),
        .inp(data_shft), .outp(datao)  );

endmodule




//1/29/2015 start
// 44-bit accumulator, no multiplication
module accumulator_44bit (nGrst, clk, rstn, 
  din_en, din,    // data comes from fabric
  p_en, pout, 
  // break_fdbk=1: write input sample in accum to start a new accumulation cycle
  break_fdbk,     // break_fdbk=0: accum loopback's on, do accumulation
  carryout );     // 1-bit carryouts if width required > 44

  // Gr MAC can add feedback, that is contents of an accum reg, to C input only.
  // Cannot add feedback to CDIN. 
  input clk, rstn, nGrst, din_en, p_en, break_fdbk;
  input  [43:0] din;
  output [43:0] pout;
  output carryout;

  MACC mac_0 (
    .CLK  ({clk,clk}),

    // Hold A and B = 0
    .A        (18'b0),
    .A_EN     (2'b11),
    .A_ARST_N ({nGrst,nGrst}),
    .A_SRST_N (2'b11),      
    .A_BYPASS (2'b11),      // bypass on

    .B        (18'b0),
    .B_EN     (2'b11),
    .B_ARST_N ({nGrst,nGrst}),
    .B_SRST_N (2'b11),
    .B_BYPASS (2'b11),      // bypass on

    .C        (din),
    .C_EN     ({din_en, din_en}),
    .C_ARST_N ({nGrst,nGrst}),
    .C_SRST_N ({rstn,rstn}),
    .C_BYPASS (2'b00),      // latch
    .CARRYIN  (1'b0),

    .P        (pout),
    .CDOUT    (),
    .P_EN     ({p_en, p_en}),
    .P_ARST_N ({nGrst,nGrst}),
    .P_SRST_N ({rstn, rstn}),
    .P_BYPASS (2'b00),      //latch

    .OVFL_CARRYOUT  (carryout),

    .CDIN (),

    // Disable SUB
    .SUB        (1'b0),
    .SUB_EN     (1'b1),           // en
    .SUB_AD     (1'b0),           // async data bit
    .SUB_AL_N   (1'b1),           // async load the data bit
    .SUB_SD_N   (1'b1),           // sync data bit
    .SUB_SL_N   (1'b0),           // sync load the data bit
    .SUB_BYPASS (1'b1),           // bypass

    // Disable SHFT
    .ARSHFT17         (1'b0),
    .ARSHFT17_EN      (1'b1),           // en
    .ARSHFT17_AD      (1'b0),           // async data bit
    .ARSHFT17_AL_N    (1'b1),           // async load the data bit
    .ARSHFT17_SD_N    (1'b1),           // sync data bit
    .ARSHFT17_SL_N    (1'b0),           // sync load the data bit
    .ARSHFT17_BYPASS  (1'b1),           // bypass

    // Register break_fdbk signal. When break_fdbk==1 pass C input to accum reg,
    // that is reset accumulator
    .FDBKSEL        (~break_fdbk),
    .FDBKSEL_EN     (1'b1),           // en
    .FDBKSEL_AD     (1'b0),           // async data bit
    .FDBKSEL_AL_N   (nGrst),          // async load the data bit
    .FDBKSEL_SD_N   (1'b1),           // sync data bit
    .FDBKSEL_SL_N   (rstn),           // sync load the data bit
    .FDBKSEL_BYPASS (1'b0),           // latch

    // Disable CDSEL
    .CDSEL        (1'b0),
    .CDSEL_EN     (1'b1),           // en
    .CDSEL_AD     (1'b0),           // async data bit
    .CDSEL_AL_N   (1'b1),           // async load the data bit
    .CDSEL_SD_N   (1'b1),           // sync data bit
    .CDSEL_SL_N   (1'b0),           // sync load the data bit
    .CDSEL_BYPASS (1'b1),           // bypass

    .OVFL_CARRYOUT_SEL  (1'b1),     // Select Ovfl 

    .SIMD(1'b0),
    .DOTP(1'b0)    );

endmodule



module decm_accumulator (nGrst, rstn, clk, 
  din, din_en,  
  acc_out, acc_en,
  break_fdbk );
  parameter ACC_WIDTH = 46;   // accumulator bitwidth including extension
  parameter CD_WIDTH  = 45;   // tap width prior to final accumulator
  
  localparam EXTEND = (ACC_WIDTH>44)? 1 : 0;    // Accumulator needs extension
  
  input nGrst, rstn, clk;
  input din_en, acc_en, break_fdbk;
  input  [CD_WIDTH-1:0] din;
  output [ACC_WIDTH-1:0] acc_out;
  
  wire [43:0] pout;
  wire [ACC_WIDTH-1:0] sign_ext_accum_inp, accumulator;        //2/9/2015
  
    // Based on required accumulator bitwidth, build either MAC-based or fabric
    // accumulator.  
    // !! To replace fabric accum with MAC-based and fabric extension !!  
  generate
    if (EXTEND==1)  begin: fabric_accum
      decm_signExt # ( .INWIDTH(CD_WIDTH),
                .OUTWIDTH(ACC_WIDTH),
                .UNSIGNED(0)) signExt_acc_inp_0 (
        .inp(din), .outp(sign_ext_accum_inp) );

      fabric_accumulator # (.BITWIDTH(ACC_WIDTH)) accum_0 (     //2/9/2015
        .nGrst(nGrst), .clk(clk),
        .clkEn(din_en),
        .rst(break_fdbk),
        .D(sign_ext_accum_inp),
        .Q(accumulator)          );

      decm_kitDelay_reg # (.BITWIDTH(ACC_WIDTH), .DELAY(1) ) acc_tick_0 (
        .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
        .inp(accumulator), .outp(acc_out)  );
    end
  endgenerate  


  generate 
    if (EXTEND==0)  begin: MAC_based_accum
      accumulator_44bit hard_accum_0 (
        .nGrst(nGrst), 
        .clk(clk), 
        .rstn(rstn), 
        .din_en(din_en), 
        .din(din),        // data comes from MAC but via fabric
        .p_en(acc_en), 
        .pout(pout), 
        .break_fdbk(break_fdbk),
        .carryout() );

      assign acc_out = pout[ACC_WIDTH-1:0];
    end
  endgenerate  
endmodule




// Extended bitwidth (>44) G4 accumulator, no multiplier
module decm_accumulator_OLD (nGrst, rstn, clk, 
  din, din_en,  
  acc_out, acc_en,
  break_fdbk );
  parameter ACC_WIDTH = 46;   // accumulator bitwidth including extension
  
  localparam EXTEND = (ACC_WIDTH>44)? 1 : 0;    // Accumulator needs extension
  localparam EXT_WIDTH = (ACC_WIDTH>44)? ACC_WIDTH-44 : 1;
  
  input nGrst, rstn, clk;
  input din_en, acc_en, break_fdbk;
  input  [43:0] din;
  output [ACC_WIDTH-1:0] acc_out;
  
  wire carryout, s;
  wire [43:0] pout;
  wire [EXT_WIDTH-1:0] extension_carryin, extension_sum, extension_fdbk; 
  reg  [EXT_WIDTH-1:0] extension_reg; 
  reg  [43:0] pout_tick;
  wire break_fdbk_t2;
  
  accumulator_44bit hard_accum_0 (
    .nGrst(nGrst), 
    .clk(clk), 
    .rstn(rstn), 
    .din_en(din_en), 
    .din(din),        // data comes from MAC but via fabric
    .p_en(acc_en), 
    .pout(pout), 
    .break_fdbk(break_fdbk),
    .carryout(carryout) );     // 1-bit carryouts if width required > 44

  // Extension bits are 1 clk delayed regarding hard P bits.  Align the two 
  // parts of the result by delaying hard P bits
  always @ (negedge nGrst or posedge clk) 
    if(nGrst==1'b0) 
      pout_tick   <= 'b0;
    else
      pout_tick   <= pout;    
      
  generate
    // Based on required accumulator bitwidth, build bit extension if necessary
    if (EXTEND==1)  begin: g4_accExt
      decm_kitDelay_bit_reg # (.DELAY(2)) accsel_pipe_0 (
        .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
        .inp(break_fdbk), .outp(break_fdbk_t2) ) ;
 
      assign s = pout[43] & carryout;
      assign extension_carryin = { {(EXT_WIDTH-1){s}}, carryout};
      assign extension_fdbk = (break_fdbk_t2==1'b1)? 'b0 : extension_reg;
      assign extension_sum = extension_fdbk + extension_carryin;
  
      always @ (negedge nGrst or posedge clk) 
        if(nGrst==1'b0) 
          extension_reg <= 'b0;
        else 
          extension_reg <= extension_sum;

      assign acc_out[ACC_WIDTH-1:44] = extension_reg;
      assign acc_out[43:0] = pout_tick;
    end

    // Or leave the original 44-bit accumulator 
    else begin: g4_noAccExt
      assign acc_out = pout_tick[ACC_WIDTH-1:0];
    end
  endgenerate

endmodule
//1/29/2015 ends