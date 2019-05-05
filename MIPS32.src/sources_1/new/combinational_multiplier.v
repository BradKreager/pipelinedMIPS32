`timescale 1ns / 1ps

module combinational_multiplier(
         input [31:0] mul_pa,
         input [31:0] mul_pb,
         input        en,
		 input        clk,
         output reg [31:0] mul_high,
         output reg [31:0] mul_low
       );


always@(*)
  begin
    if(en)
      begin
        {mul_high, mul_low} <= mul_pa * mul_pb;
      end
  end

endmodule
