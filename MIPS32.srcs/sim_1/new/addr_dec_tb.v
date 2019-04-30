`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 06:33:50 PM
// Design Name: 
// Module Name: addr_dec_tb
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


module addr_dec_tb();
    reg we;
    reg [31:0]a;
    
    wire we_gpio;
    wire we_fact;
    wire we_mem;
    wire [1:0] rd_sel;
    
    addr_dec DUT(
        .we(we),
        .a(a),
        .we_gpio(we_gpio),
        .we_fact(we_fact),
        .we_mem(we_mem),
        .rd_sel(rd_sel)
    );
    
    task comb_tick;
        begin
            #5;
        end
    endtask
    
    initial begin
        we = 1'b1;
        for(a = 32'b0; a < 32'h90F; a = a + 1) begin
            comb_tick;
        end
        we = 1'b0;
        for(a = 32'b0; a < 32'h90F; a = a + 1) begin
            comb_tick;
        end
    end
    
endmodule
