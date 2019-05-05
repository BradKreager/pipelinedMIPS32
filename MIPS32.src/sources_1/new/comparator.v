`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2018 12:14:58 PM
// Design Name: 
// Module Name: comp
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


module comparator#(parameter WIDTH=32)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    output gt
    );
    
    assign gt = (a > b) ? 1 : 0;
endmodule