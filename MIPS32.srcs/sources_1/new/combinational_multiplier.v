`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2019 09:06:03 PM
// Design Name: 
// Module Name: combinational_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module combinational_multiplier(
    input [31:0] mul_pa,
    input [31:0] mul_pb,
    output [31:0] mul_high,
    output [31:0] mul_low
    );

	reg [63:0] result;

	assign {mul_high, mul_low} = result;

	always@(*) begin
		result = mul_pa * mul_pb;
	end

endmodule
