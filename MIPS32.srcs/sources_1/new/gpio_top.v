`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 06:36:46 PM
// Design Name: 
// Module Name: gpio_top
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


module gpio_top # (parameter WIDTH = 32)(    
    input wire we,
    input wire rst,
    input wire clk,
    
    input wire [1:0] a,
    
    input wire [WIDTH-1:0] gpI1,
    input wire [WIDTH-1:0] gpI2,
    
    input wire [WIDTH-1:0] wd,
    
    output wire [WIDTH-1:0] rd,
    output wire [WIDTH-1:0] gpO1,
    output wire [WIDTH-1:0] gpO2
    );
    
    wire we2;
    wire we1;
    wire [1:0] rdsel;
    
    dreg_sync_rst_en #(WIDTH) gpO1_reg(
        .clk(clk),
        .rst(rst),
        .en(we1),
        .d(wd),
        .q(gpO1)
    );
    
    dreg_sync_rst_en #(WIDTH) gpO2_reg(
        .clk(clk),
        .rst(rst),
        .en(we2),
        .d(wd),
        .q(gpO2)
    );
    
    mux4 #(WIDTH) rd_mux(
        .sel(rdsel),
        .a(gpI1),
        .b(gpI2),
        .c(gpO1),
        .d(gpO2)
    );
    
    gpio_ad addr (
        .a(a),
        .we(we),
        .we2(we2),
        .we1(we1),
        .rdsel(rdsel)
    );
    
endmodule
