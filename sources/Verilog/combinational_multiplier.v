`timescale 1ns / 1ps

module combinational_multiplier(
	input [31:0] mul_pa,
	input [31:0] mul_pb,
	input        en,
	input        clk,
	output wire [31:0] mul_high,
	output wire [31:0] mul_low
);

	assign {mul_high, mul_low} = mul_pa * mul_pb;

endmodule
