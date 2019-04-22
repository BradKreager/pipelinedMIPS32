`timescale 1ns / 1ps

module combinational_multiplier(
         input [31:0] mul_pa,
         input [31:0] mul_pb,
         input        en,
         output [31:0] mul_high,
         output [31:0] mul_low
       );

reg [63:0] result;

assign {mul_high, mul_low} = result;

always@(*)
  begin
    if(en)
      begin
        result = mul_pa * mul_pb;
      end
    else
      begin
        result = result;
      end
  end

endmodule
