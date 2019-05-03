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
    integer errors = 0;
    initial begin
        gpI1 = 1;
        reset;
		#5;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 1) errors = errors + 1;
        reset;
        #5;
        gpI1 = 2;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 2) errors = errors + 1;
                reset;
        #5;
        gpI1 = 3;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 6) errors = errors + 1;
                reset;
        #5;
        gpI1 = 4;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 24) errors = errors + 1;
                reset;
        #5;
        gpI1 = 5;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 120) errors = errors + 1;
                reset;
        #5;
        gpI1 = 6;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 720) errors = errors + 1;
                reset;
        #5;
        gpI1 = 7;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 5040) errors = errors + 1;
        reset;
        #5;
        gpI1 = 8;
        while(pc_current != 32'h40) tick;
        if (gpO2 != 40320) errors = errors + 1;
        $finish;
    end
endmodule
