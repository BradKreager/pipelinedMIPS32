`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 07:59:27 PM
// Design Name: 
// Module Name: disp_hex_mux
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


module disp_hex_mux(
        input [15:0] hex,
        input clk,
        input rst,
        
        output an,
        output sseg
    );
    
    hex_to_7seg hex0();
    hex_to_7seg hex1();
    hex_to_7seg hex2();
    hex_to_7seg hex3();
endmodule
