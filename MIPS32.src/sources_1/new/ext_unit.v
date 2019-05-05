`timescale 1ns / 1ps

module ext_unit(
	input  wire        ext_sign0_zero1,
	input  wire [15:0] a,
	output wire [31:0] y
);

assign y = ext_sign0_zero1 ? {{16{1'b0}}, a} : {{16{a[15]}}, a};

endmodule
