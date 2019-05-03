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
        output reg sseg
    );
    wire [7:0]hex0_out;
    wire [7:0]hex1_out;
    wire [7:0]hex2_out;
    wire [7:0]hex3_out;
    reg [1:0] sel;
    assign an = sel;

    hex_to_7seg hex0(
        .HEX(hex[3:0]),
        .s(hex0_out)
    );
    
    hex_to_7seg hex1(
        .HEX(hex[7:4]),
        .s(hex1_out)
    );
    
    hex_to_7seg hex2(
        .HEX(hex[11:8]),
        .s(hex2_out)
    );
    hex_to_7seg hex3(
        .HEX(hex[15:12]),
        .s(hex3_out)
    );
    
    mux4 #(8) out_mux(
        .a(hex0_out),
        .b(hex1_out),
        .c(hex2_out),
        .d(hex3_out),
        .sel(sel)
    );
    
    always @(posedge clk) begin
        sel = sel + 1;
    end
    
endmodule
