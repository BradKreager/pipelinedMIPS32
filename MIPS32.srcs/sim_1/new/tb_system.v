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
    reg clk = 0;
    reg rst;
    reg [31:0]gpI1;
    wire [31:0]gpI2;
    
    wire [31:0]gpO2;
    wire [31:0]gpO1;
    wire [31:0] rT0;
    wire [31:0]pc_current;    
    
    system DUT(
		.rT0(rT0),
        .clk(clk),
        .rst(rst),
        .gpI1(gpI1),
        .gpI2(gpI2),
        .gpO1(gpO1),
        .gpO2(gpO2),
        .pc_current(pc_current)
    );
    
    assign gpI2 = gpO1;
    
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    integer i = 0;
    initial begin
        gpI1 = 5;
        reset;
		#5;
        while(pc_current != 32'h40) tick;

        reset;
		#5;
        while(pc_current != 32'h40) tick;

        $finish;
    end
endmodule
