`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2018 11:57:54 PM
// Design Name: 
// Module Name: comb_multiplier
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

// This is a 32 bit output combinational multiplier that I used for the factorial accelerator
// We can probably modify the factorial accelerator to use the existing combinational multiplier
module comb_multiplier32#(parameter WIDTH=32)(
        input [WIDTH-1:0]x,
        input [WIDTH-1:0]y,
        input clk, rst,
        
        output [WIDTH-1:0]z
    );
    assign z = x * y;
endmodule
