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
    
    output [3:0]an,
    output [7:0]sseg,
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

assign led = gpO1[1:0];
assign n = gpI1[4:0];

system system(
    .clk(clk),
    .rst(rst),
    .gpO1(gpO1),
    .gpO2(gpO2),
    .gpI1(gpI1),
    .gpI2(gpO1)
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

wire [7:0]  digit0;
wire [7:0]  digit1;
wire [7:0]  digit2;
wire [7:0]  digit3;

hex_to_7seg hex3 (
              .HEX                (hex[15:12]),
              .s                  (digit3)
            );

hex_to_7seg hex2 (
              .HEX                (hex[11:8]),
              .s                  (digit2)
            );

hex_to_7seg hex1 (
              .HEX                (hex[7:4]),
              .s                  (digit1)
            );

hex_to_7seg hex0 (
              .HEX                (hex[3:0]),
              .s                  (digit0)
            );

led_mux led_mux (
          .clk                (ls_clk),
          .rst                (rst),
          .LED3               (digit3),
          .LED2               (digit2),
          .LED1               (digit1),
          .LED0               (digit0),
          .LEDSEL             (an),
          .LEDOUT             (sseg)
        );


endmodule
