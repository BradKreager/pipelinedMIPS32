`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2019 02:24:30 PM
// Design Name: 
// Module Name: barrel_shifter
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


module barrel_shifter(
	input			Dir,
    input [31:0]	Din,
    input [4:0]		Shift_By,
    output [31:0]	Dout
    );
 
	assign Dout = Dir ? (Din >> Shift_By) : (Din << Shift_By);
	
endmodule
