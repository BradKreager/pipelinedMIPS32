`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 06:43:54 PM
// Design Name: 
// Module Name: dreg_en
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


module dreg_sync_rst_en # (parameter WIDTH = 32) (
        input  wire             clk,
        input  wire             rst,
        input  wire             en,
        input  wire [WIDTH-1:0] d,
        output reg  [WIDTH-1:0] q
    );

    always @ (posedge clk, posedge rst) begin
        if      (rst)   q <= 0;
        else if (en)    q <= d;
        else            q <= q;
    end
endmodule
