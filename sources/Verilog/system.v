`timescale 1ns / 1ps


module system (

	input clk,
	input rst,

	input [31:0]gpI1,
	input [31:0]gpI2,

	output [31:0]gpO2,
	output [31:0]gpO1,
	output [31:0]pc_current
);

	// wire [31:0] DONT_USE;
	wire [31:0] alu_out;
	wire [31:0] instr;
	wire [31:0] soc_rd;
	wire [31:0] wd_dm;
	wire [31:0] rd_dm;
	wire we_dmM;



	mips MIPS(

		.clk                         (clk),
		.rst                         (rst),
		.instr                       (instr),
		.rd_dm                       (soc_rd),
		.we_dmM                      (we_dmM),
		.pc_current                  (pc_current),
		.alu_out                     (alu_out),
		.wd_dm                       (wd_dm)
	);
	wire we_gpio;
	wire we_fact;
	wire we_mem;

	wire [1:0]rd_sel;

	wire [31:0]fact_rd;
	wire [31:0]gpio_rd;

	imem imem (
		.a              (pc_current[7:2]),
		.y              (instr)
	);

	dmem dmem (
		.clk            (clk),
		.we             (we_mem),
		.a              (alu_out[7:2]),
		.d              (wd_dm),
		.q              (rd_dm)
	);


	addr_dec addr(
		.we(we_dmM),
		.a(alu_out[31:0]),
		.we_gpio(we_gpio),
		.we_fact(we_fact),
		.we_mem(we_mem),
		.rd_sel(rd_sel)
	);

	fact_top fact(
		.a(alu_out[3:2]),
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
		.a(alu_out[3:2]),
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
