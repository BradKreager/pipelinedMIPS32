`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2018 12:04:45 PM
// Design Name: 
// Module Name: mux2
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

module updown#(parameter WIDTH=8)(
    //Control inputs
    input rst,
    input ld,
    input clk,
    input ce,
    //Data inputs
    input [WIDTH-1:0]d,
    //Data control signals
    input ud,
    //Outputs
    output reg [WIDTH-1:0]q
    );
    always @(posedge clk, posedge rst) begin
        //Async reset
        if(rst)begin
           q = 0;
           $display("COUNT: Reset");
        end
        else if(clk) begin
            //Synchronous load
            if(ld & ce) begin
                q <= d;
                $display("COUNT: Loaded %d", q);
            end
            //Synchronous down count
            else if(!ud & ce) begin
                q <= q - 1;
                $display("COUNT: --, %d", q);
            end
            //Synchronous up count
            else if(ud & ce) begin
                q <= q + 1;
                $display("COUNT: ++, %d", q);
            end
            //Otherwise, hold state
            else begin
                q <= q;
            end
        end
    end
endmodule
