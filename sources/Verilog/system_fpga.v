`timescale 1ns / 1ps

module system_fpga(
	input btn_rst,
	input btn_clk,
	input hs_clk,
	input display_sw,
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
	wire [31:0]pc;

	assign gpI2 = gpO1;
	assign led = gpO1[4:0];
	assign gpI1 = {27'b0, n};

	system SOC(
		.pc_current         (pc),
		.clk                (clk),
		.rst                (btn_rst),
		.gpO1               (gpO1),
		.gpO2               (gpO2),
		.gpI1               (gpI1),
		.gpI2               (gpI2)
	);

	clk_gen clk_gen(
		.clk100MHz          (hs_clk),
		.rst                (btn_rst),
		.clk_5KHz           (ls_clk)
	);

	button_debouncer bd_clk(
		.clk                (ls_clk),
		.button             (btn_clk),
		.debounced_button   (clk)
	);

	mux2 #(16)gpO2_mux(
		.a                  (gpO2[15:0]),
		.b                  (gpO2[31:16]),
		.sel                (gpO1[1]),
		.y                  (hex)
	);

	wire [7:0]  digit0;
	wire [7:0]  digit1;
	wire [7:0]  digit2;
	wire [7:0]  digit3;

	wire [3:0]hex0_mux_out;
	mux2 #(4)hex0_mux(
	   .a(hex[3:0]),
	   .b(pc[3:0]),
	   .sel(display_sw),
	   .y(hex0_mux_out)
	);
	
	wire [3:0]hex1_mux_out;
	mux2 #(4)hex1_mux(
	   .a(hex[7:4]),
	   .b(pc[7:4]),
	   .sel(display_sw),
	   .y(hex1_mux_out)
	);
	
	wire [3:0]hex2_mux_out;
	mux2 #(4)hex2_mux(
	   .a(hex[11:8]),
	   .b(pc[11:8]),
	   .sel(display_sw),
	   .y(hex2_mux_out)
	);
    
    wire [3:0]hex3_mux_out;
	mux2 #(4)hex3_mux(
	   .a(hex[15:12]),
	   .b(pc[15:12]),
	   .sel(display_sw),
	   .y(hex3_mux_out)
	);
	
	hex_to_7seg hex3 (
		.HEX                (hex3_mux_out),
		.s                  (digit3)
	);

	hex_to_7seg hex2 (
		.HEX                (hex2_mux_out),
		.s                  (digit2)
	);

	hex_to_7seg hex1 (
		.HEX                (hex1_mux_out),
		.s                  (digit1)
	);

	hex_to_7seg hex0 (
		.HEX                (hex0_mux_out),
		.s                  (digit0)
	);
	

    led_mux led_mux (
		.clk                (ls_clk),
		.rst                (btn_rst),
		.LED3               (digit3),
		.LED2               (digit2),
		.LED1               (digit1),
		.LED0               (digit0),
		.LEDSEL             (an),
		.LEDOUT             (sseg)
	);
endmodule
