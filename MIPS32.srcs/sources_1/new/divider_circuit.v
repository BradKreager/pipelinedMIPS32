`timescale 1ns / 1ps

module divider_circuit(
    input [31:0] inA,
    input [31:0] inB,
    // input en,
    output [31:0] outQ,
    output [31:0] outR
    );

	assign outQ = inA / inB;

	assign outR = inA % inB;
	
endmodule
