`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 11:30:53 PM
// Design Name: 
// Module Name: fact_ad
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


module fact_ad(
    input wire [1:0]a,
    input wire we,
    output reg we1,
    output reg we2,
    output wire [1:0]rd_sel
    );
    
    assign rd_sel = a;
    
    always @(*) begin
        case (a)
            //Location 00: Selects the input register for writing, outputs the input value
            2'b00: begin
                we1 = we;
                we2 = 1'b0;
            end
            
            //Location 01: Selects the go register for writing, outputs the go signal
            2'b01: begin
                we1 = 1'b0;
                we2 = we;
            end
            
            //Location 10: Disables all writes, outputs the status (err and done bits)
            2'b10: begin
                we1 = 1'b0;
                we2 = 1'b0;
            end
            
            //Location 11: Disables all writes, outputs the result
            2'b11: begin
                we1 = 1'b0;
                we2 = 1'b0;
            end
            
            default begin
                we1 = 1'bx;
                we2 = 1'bx;
            end
        endcase
    end
endmodule
