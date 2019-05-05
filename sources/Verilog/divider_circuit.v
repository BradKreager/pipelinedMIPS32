`timescale 1ns / 1ps

module divider_circuit(
	input [31:0] inA,
	input [31:0] inB,
	output wire [31:0] outQ,
	output wire [31:0] outR
);

	assign outQ = inA / inB;
	assign outR = inA % inB;

endmodule
