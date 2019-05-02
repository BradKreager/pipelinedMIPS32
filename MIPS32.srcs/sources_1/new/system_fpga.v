`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 07:55:52 PM
// Design Name: 
// Module Name: system_fpga
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


module system_fpga(
    input btn_rst,
    input btn_clk,
    input hs_clk,
    input sel,
    input [4:0]n,
    
    output an,
    output sseg,
    output [4:0]led
);

wire [31:0]gpI1;
wire [31:0]gpI2;
wire rst;

wire [31:0]gpO1;
wire [31:0]gpO2;
wire ls_clk;
wire clk;
wire [15:0]hex;

assign gpO1 = {27'b0, led};
assign gpI1 = {27'b0, n};

assign gpI2 = gpO1;

system system(
    .clk(clk),
    .rst(rst),
    .gpO1(gpO1),
    .gpO2(gpO2),
    .gpI1(gpI1),
    .gpI2(gpI2)
);

clk_gen clk_gen(
    .clk100MHz(hs_clk),
    .rst(rst),
    .clk_5KHz(ls_clk)
);

button_debouncer bd_clk(
    .clk(ls_clk),
    .button(btn_clk),
    .debounced_button(clk)
);

button_debouncer bd_rst(
    .clk(ls_clk),
    .button(btn_rst),
    .debounced_button(rst)
);

mux2 #(15)gpO2_mux(
    .a(gpO2[15:0]),
    .b(gpO2[31:16]),
    .sel(gpO1[1]),
    .y(hex)
);
disp_hex_mux hex_mux(
    .hex(hex),
    .clk(ls_clk),
    .rst(rst),
    .an(an),
    .sseg(sseg)
);

endmodule
