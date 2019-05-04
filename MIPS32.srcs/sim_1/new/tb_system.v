`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 09:05:21 PM
// Design Name: 
// Module Name: tb_system
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


module tb_system();
    reg clk;
    reg rst;
    reg [31:0]gpI1;
    wire [31:0]gpI2;
    
    wire [31:0]gpO2;
    wire [31:0]gpO1;
    wire [31:0]pc_current;    
    
    system DUT(
        .clk(clk),
        .rst(rst),
        .gpI1(gpI1),
        .gpI2(gpI2),
        .gpO1(gpO1),
        .gpO2(gpO2),
        .pc_current(pc_current)
    );
    
    assign gpI2 = gpO1;
    
    task tick; begin 
            clk = 1'b0; #5;
            clk = 1'b1; #5;
        end
    endtask
    
    integer exp_factorial = 0;
    integer test;
    integer product = 1;

    task calc_factorial; begin
            product = 1;
            while(test > 1) begin
                product = product * test;
                test = test - 1;
            end
            exp_factorial = product;
        end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    integer errors = 0;
    integer n = 0;
    integer i = 0;
    initial begin
		for(i = 1; i < 13; i = i + 1) begin
		    reset; #5;
		    gpI1 = i;
		    test = i;
		    while(pc_current != 32'h40) tick;
		    calc_factorial;
            if (gpO2 != exp_factorial) errors = errors + 1;
		end
        $finish;
    end
endmodule
