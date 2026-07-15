// ***************************************************************************/
//Actel Corporation Proprietary and Confidential
//Copyright 2008 Actel Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  CoreEDAC RTL Component Library
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

//    ########    ########   ##           ###     ##    ##
//    ##     ##   ##         ##          ## ##     ##  ##
//    ##     ##   ##         ##         ##   ##     ####
//    ##     ##   ######     ##        ##     ##     ##
//    ##     ##   ##         ##        #########     ##
//    ##     ##   ##         ##        ##     ##     ##
//    ########    ########   ########  ##     ##     ##


//----------- Register-based 1-bit Delay has only input and output ---------
module enum_kitDelay_bit_reg(nGrst, rst, clk, clkEn, inp, outp);
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


//----------- Register-based Multi-bit Delay has only input and output ---------
module enum_kitDelay_reg(nGrst, rst, clk, clkEn, inp, outp);
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
/*
  enum_kitDelay_reg # (.BITWIDTH(DATA_WIDTH), .DELAY(WRAP_LAYERS) ) wrap_layer_0 (
      .nGrst(NGRST), .rst(1'b0), .clk(CLK), .clkEn(1'b1), 
      .inp(DATAI), 
      .outp(datai_wrap) );
*/

// Result: Resizes the vector inp to the specified size.
// To create a larger vector, the new [leftmost] bit positions are filled
// with the sign bit (if UNSIGNED==0) or 0's (if UNSIGNED==1).
// When truncating, the sign bit is retained along with the rightmost part
// (if UNSIGNED==0), or the leftmost bits are all dropped (if UNSIGNED==1)
module enum_signExt (inp, outp);
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
  enum_signExt # ( .INWIDTH(DATA_WIDTH),
              .OUTWIDTH(DATA_WIDTH_MAC),
              .UNSIGNED(UNSIGNED)) signExt_0 (
    .inp(data), .outp(data2mac)   );
*/

// A shift register to enter reloadable coefficients
module enum_coef_sr (nGrst, rstn, clk, clkEn,
        coefi,
        coefi_valid,
        flat_coefo  );
  parameter TAPS        = 100;
  parameter COEF_WIDTH  = 12;

  input nGrst, rstn, clk, clkEn;
  input [COEF_WIDTH-1:0] coefi;
  input coefi_valid;
  output[TAPS*COEF_WIDTH-1:0] flat_coefo;

  reg [COEF_WIDTH-1:0] shift_reg [0:TAPS-1];
  integer i;

  generate
    genvar j;
    for(j=0; j<TAPS; j=j+1)  begin: array2flat
      assign flat_coefo[COEF_WIDTH*j +: COEF_WIDTH] = shift_reg[j];
    end
  endgenerate

  always @ (posedge clk or negedge nGrst)
    if(!nGrst)
      for(i=0; i<TAPS; i=i+1)
        shift_reg[i] <= 'b0;
    else if(clkEn)
      if(rstn==1'b0)
        for(i=0; i<TAPS; i=i+1)
          shift_reg[i] <= 'b0;
      else
        if(coefi_valid) begin
          for(i=TAPS-1; i>0; i=i-1)
            shift_reg[i] <= shift_reg[i-1];
          shift_reg[0] <= coefi;
        end
endmodule


//rt
// Asynchronous global reset synchronizer generates a 1 or 2-clk wide sync'ed 
// pulse on rising edge of the async reset. It also generates a nice copy of 
// nGrst with rear positive edge sync'ed to clk
module enum_kitSync_ngrst (nGrst, clk, pulse, synced_ngrst);
  parameter PULSE_WIDTH = 1;
  
  input nGrst, clk;
  output pulse, synced_ngrst;
  
  reg pulse; 
  reg tick1, tick2;
  wire synced_ngrst, pulsei;

  // Synchronize nGrst
  enum_kitDelay_bit_reg # (.DELAY(4)) sync_ngrst_0 (
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