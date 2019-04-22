`timescale 1ns / 1ps

module divider_circuit(
         input [31:0] inA,
         input [31:0] inB,
         input en,
         output reg [31:0] outQ,
         output reg [31:0] outR
       );

always @(*)
  begin
    if(en)
      begin
        outQ = inA / inB;
        outR = inA % inB;
      end
    else
      begin
        outQ = outQ;
        outR = outR;
      end
  end
endmodule
