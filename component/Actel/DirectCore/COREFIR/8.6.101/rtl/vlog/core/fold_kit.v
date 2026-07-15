// ***************************************************************************/
//Actel Corporation Proprietary and Confidential
//Copyright 2008 Actel Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  CoreFIR RTL Component Library
//              Various Standard RTL Modules
//
//Revision Information:
//Date         Description
//08Jan2009    Initial Release
//
//SVN Revision Information:
//SVN $Revision: $
//SVN $Data: $
//
//Resolved SARs
//SAR     Date    Who         Description
//
//Notes:
//

`timescale 1 ns/100 ps
`define STANDALONE


// ----------- Simple one-DFF Edge Detector ------------
module fold_kitEdge (nGrst, rst, clk, inp, outp);
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
 fold_kitEdge # (.REDGE(1)) edge_detect_0 (
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
module fold_kitDelay_bit_reg(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  inp;
  output outp;
  // extra register to avoid error if DELAY==0
  reg delayLine [0:DELAY];
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)         delayLine[i] <= 1'b0;
        else
          if (rst)
            for (i = 0; i<DELAY; i=i+1)  delayLine[i] <= 1'b0;
          else
            if (clkEn) begin
              for(i=DELAY-1; i>=1; i=i-1)  delayLine[i] <= delayLine[i-1];
              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/* Use
  fold_kitDelay_bit_reg # (.DELAY(2)) bit_dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .inp(input), .outp(outp) ) ;
*/

module fold_kitDelay_reg(nGrst, rst, clk, clkEn, inp, outp);
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
  fold_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(1) ) dly_0 (
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
module fold_kitCountS(nGrst, rst, clk, clkEn, cntEn, Q, dc);
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
  fold_kitCountS # ( .WIDTH(WIDTH), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .cntEn(cntEn), .Q(outp), .dc() );
*/

//complex counter
module fold_kitCountC(nGrst, rst, clk, clkEn, cntEn, up, ld, din, Q, dc);
  parameter WIDTH = 16;     // in bits
  parameter UPDOWN = 2;  // 0 - up, 1-down, 2 - up/down
  parameter DCVALUE = (1 << WIDTH) - 1; // state to decode
  parameter BUILD_CLKEN = 1;
  parameter BUILD_RST = 1;
  parameter BUILD_LD = 1;
  parameter BUILD_DC = 1;

  input nGrst, rst, clk, clkEn, cntEn, up, ld;
  input [WIDTH-1:0] din;
  output [WIDTH-1:0] Q;
  output dc;  // decoder output
  reg [WIDTH-1:0] Q;

  assign dc = (BUILD_DC==1)? (Q == DCVALUE) : 1'bx;

  always@(negedge nGrst or posedge clk) begin
    if(!nGrst) Q <= {WIDTH{1'b0}};
    else
      if(clkEn || (BUILD_CLKEN==0) ) begin // if clkEn, or no clkEn input at all
        if(rst && BUILD_RST) Q <= {WIDTH{1'b0}};
        else begin
          if(ld && BUILD_LD)  Q <= din; // sync load
          else
            if(cntEn) begin  // regular count
              if(UPDOWN==0)           Q <= Q + 1'b1;
              if(UPDOWN==1)           Q <= Q - 1'b1;
              if((UPDOWN==2) && up)   Q <= Q + 1'b1;
              if((UPDOWN==2) && !up)  Q <= Q - 1'b1;
            end // count
        end
      end
  end // always
endmodule

/* instance
  fold_kitCountC # ( .WIDTH(WIDTH), .UPDOWN(0), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_CLKEN(1), .BUILD_RST(1), .BUILD_LD(0),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn), .cntEn(cntEn),
    .up(1'bx), .ld(1'bx), .din({WIDTH{1'bx}}), .Q(outp), .dc() );
*/


// Result: Resizes the vector inp to the specified size.
// To create a larger vector, the new [leftmost] bit positions are filled
// with the sign bit (if UNSIGNED==0) or 0's (if UNSIGNED==1).
// When truncating, the sign bit is retained along with the rightmost part
// if UNSIGNED==0.  Otherwise (UNSIGNED==1) the leftmost bits are all dropped.
module fold_signExt (inp, outp);
  parameter INWIDTH = 16;
  parameter OUTWIDTH = 20;
  parameter UNSIGNED = 0;   // 0-signed conversion; 1-unsigned

  input [INWIDTH-1:0] inp;
  output[OUTWIDTH-1:0] outp;

  generate
    if(INWIDTH >= OUTWIDTH) begin
      assign outp[OUTWIDTH-1] = UNSIGNED ? inp[OUTWIDTH-1] : inp[INWIDTH-1];
      assign outp[OUTWIDTH-2:0] = inp[OUTWIDTH-2:0];
    end
    else
      assign outp = UNSIGNED ?  {{(OUTWIDTH-INWIDTH){1'b0}}, inp} :
                                {{(OUTWIDTH-INWIDTH){inp[INWIDTH-1]}}, inp};
  endgenerate
endmodule
/* usage:
  fold_signExt # ( .INWIDTH(DATA_WIDTH),
              .OUTWIDTH(DATA_WIDTH_MAC),
              .UNSIGNED(UNSIGNED)) signExt_0 (
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
module fold_RAM_fabric (nGrst, RCLOCK, WCLOCK,
       WRB, RDB,
       DI,
       RADDR, WADDR,
       DO       );
  parameter
    BITWIDTH  = 16,
    RAM_DEPTH = 256,
    RAM_LOGDEPTH = 8;

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


//rt
// Asynchronous global reset synchronizer generates 
//  1. A 1 or 2-clk wide sync'ed pulse on rear (rising) edge of the async reset
//  2. A copy of nGrst (synced_ngrst) with synced rear (rising) edge.  The 
//     synced_ngrst starts asynchronously but ends sync'd to clk
module fold_kitSync_ngrst (nGrst, clk, pulse, synced_ngrst);
  parameter PULSE_WIDTH = 1;
  
  input nGrst, clk;
  output pulse, synced_ngrst;
  
  reg pulse; 
  reg tick1, tick2;
  wire pulsei;

  // Synchronize nGrst
  fold_kitDelay_bit_reg # (.DELAY(4)) sync_ngrst_0 (
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
