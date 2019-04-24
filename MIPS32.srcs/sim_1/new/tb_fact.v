`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:23:32 AM
// Design Name: 
// Module Name: tb_fact
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


module tb_fact();
    
    reg [1:0]a_t;
    reg we_t;
    reg [3:0]wd_t;
    reg rst_t;
    reg clk_t;
    
    wire [31:0]rd_t;
    
    fact_top DUT(
        .a(a_t),
        .we(we_t),
        .wd(wd_t),
        .rst(rst_t),
        .clk(clk_t),
        .rd(rd_t)
    );
    
    task tick;
      begin
        clk_t = 1'b0;
        #5;
        clk_t = 1'b1;
        #5;
      end
    endtask
    
    task reset;
      begin
        rst_t = 1'b0;
        #5;
        rst_t = 1'b1;
        #5;
        tick;
        rst_t = 1'b0;
      end
    endtask
    
    integer errors = 0;
    integer test_value = 32'h0;
    
    initial begin
        reset;
        tick;
    end
endmodule
