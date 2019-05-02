`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 07:33:16 PM
// Design Name: 
// Module Name: system
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
module system (
    input clk,
    input rst,
    
    input [31:0]gpI1,
    input [31:0]gpI2,
    
    output [31:0]gpO2,
    output [31:0]gpO1
    );

// wire [31:0] DONT_USE;
wire [31:0] pc_current;
wire [31:0] alu_out;
wire [31:0] instr;
wire [31:0] soc_rd;
wire [31:0] wd_dm;
wire [31:0] rd_dm;
wire we_dm;

mips mips (
`ifdef SIM
       .rd1(rd1),
       .a_ctrl (a_ctrl),
       .alu_pb (alu_pb),
`endif
       .clk            (clk),
       .rst            (rst),
       //.ra3            (ra3),
       .instr          (instr),
       .rd_dm          (soc_rd),
       .we_dm          (we_dm),
       .pc_current     (pc_current),
       .alu_out        (alu_out),
       .wd_dm          (wd_dm)
        //.rd3            (rd3)
     );

imem imem (
       .a              (pc_current[7:2]),
       .y              (instr)
     );

dmem dmem (
       .clk            (clk),
       .we             (we_dm),
       .a              (alu_out[7:2]),
       .d              (wd_dm),
       .q              (rd_dm)
     );

 wire we_gpio;
 wire we_fact;
 wire we_mem;

 wire [1:0]rd_sel;
 
 wire [31:0]fact_rd;
 wire [31:0]gpio_rd;

 addr_dec addr(
    .we(we_dm),
    .a(pc_current),
    .we_gpio(we_gpio),
    .we_fact(we_fact),
    .we_mem(we_mem), 
    .rd_sel(rd_sel)
 );

 fact_top fact(
    .a(pc_current[3:2]),
    .we(we_fact),
    .wd(wd_dm[3:0]),
    .clk(clk),
    .rst(rst),
    .rd(fact_rd)
    );
 
 gpio_top gpio(
    .clk(clk),
    .rst(rst),
    .wd(wd_dm),
    .rd(gpio_rd),
    .we(we_gpio),
    .a(pc_current[3:0]),
    .gpO1(gpO1),
    .gpO2(gpO2),
    .gpI1(gpI1),
    .gpI2(gpI2)
 );
 
 mux4 #(32) rd_mux(
    .a(rd_dm),
    .b(rd_dm),
    .c(fact_rd),
    .d(gpio_rd),
    .y(soc_rd),
    .sel(rd_sel)
 );

endmodule
