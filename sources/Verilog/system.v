`timescale 1ns / 1ps

 
 
module system (
`ifdef SIM
	output  wire        lwstall,
	output  wire        branchstall,
	output wire  forwardAE,
	output wire  forwardBE,
	output wire  forwardAD,
	output wire  forwardBD,
	output wire  stallF,
	output wire  stallD,
	output wire  flushE,
	output wire [4:0] rsD,
	output wire [4:0] rtD,
	output wire [4:0] rdD,
	output wire [4:0] rsE,
	output wire [4:0] rtE,
	output wire  we_regM,
	output wire  we_regW,
	output wire [4:0] rf_waM,
	output wire [4:0] rf_waW,
	output wire  jal_wd_selM,
	output wire  jal_wd_selE,
	output wire  branch,
	output wire  muldiv_enE,
	output wire  muldiv_enE_qual,
	output wire  hilo_read_done,
	output wire [31:0] rAT,
	output wire [31:0] rV0,
	output wire [31:0] rV1,
	output wire [31:0] rA0,
	output wire [31:0] rA1,
	output wire [31:0] rA2,
	output wire [31:0] rT0,
	output wire [31:0] rT1,
	output wire [31:0] rT2,
	output wire [31:0] rT3,
	output wire [31:0] rT4,
	output wire [31:0] rT5,
	output wire [31:0] rT6,
	output wire [31:0] rT7,
	output wire [31:0] rS0,
	output wire [31:0] rS1,
	output wire [31:0] rS2,
	output wire [31:0] rS3,
	output wire [31:0] rS4,
	output wire [31:0] rS5,
	output wire [31:0] rS6,
	output wire [31:0] rS7,
	output wire [31:0] rT8,
	output wire [31:0] rT9,
	output wire [31:0] rK0,
	output wire [31:0] rK1,
	output wire [31:0] rGP,
	output wire [31:0] rSP,
	output wire [31:0] rFP,
	output wire [31:0] rRA,
	output wire [31:0] wd_rfW,
	output wire  branchE,
	output wire  jumpE,
	output wire  alu_src_immE,
	output wire  we_regE,
	output wire  hilo_mov_opE,
	output wire  hilo_mov_opM,
	output wire  hilo_mov_opW,
	output wire  hi0_lo1_selE,
	output wire  mul0_div1_selE,
	output wire  mul0_div1_selM,
	output wire  dm_load_opE,
	output wire  wr_ra_jalE,
	output wire  jr_selE,
	output wire  wr_ra_instrE,
	output wire  slt_opE,
	output wire  arith_opE,
	output wire [2:0] alu_ctrlE,
	output wire  signExt0_zeroExt1E,
	output wire  dm_load_opM,
	output wire  dm_load_opW,
	output wire  jal_wd_selW,
	output wire  mul0_div1_selW,
	output wire [31:0] pc_plus4D,
	output wire [31:0] pc_plus4E,
	output wire  zero,
	output wire  equalsD,
	output wire [31:0] wd_hiloW,
	output wire [31:0] wd_alu_dmW,
	output wire [31:0] rd1_outE,
	output wire [31:0] rd2_outE,
	output wire [31:0] sext_immE,
	output wire [4:0] rdE,
	output wire [4:0] shamtE,
	output wire [4:0] rf_waE,
	output wire [31:0] alu_outE,
	output wire [31:0] alu_outM,
	output wire [31:0] alu_outW,
	output wire [31:0] hilo_mux_outM,
	output wire [31:0] hilo_mux_outE,
	output wire [31:0] pc_plus8M,
	output wire [31:0] pc_plus8W,
	output wire [31:0] rd_dmW,
	output wire [31:0] hilo_mux_outW,
	output wire [31:0] pc_plus8E,
	output wire [31:0] alu_pb,
	output wire [2:0] a_ctrl,
	output wire [31:0] rd1,
	output wire [31:0] instrD,
	output wire  arith_overflow,
	output wire [31:0] instr,
	output wire [31:0] alu_out,
	output wire [31:0] soc_rd,
	output wire [31:0] wd_dm,
	output wire  we_dmM,
	output wire [31:0] rd_dm,
	output wire [4:0] ra3,
	output wire [31:0] rd3,
`endif
input clk,
input rst,

input [31:0]gpI1,
input [31:0]gpI2,

output [31:0]gpO2,
output [31:0]gpO1,
output [31:0]pc_current
);

// wire [31:0] DONT_USE;
`ifndef SIM
	wire [31:0] alu_out;
	wire [31:0] instr;
	wire [31:0] soc_rd;
	wire [31:0] wd_dm;
	wire [31:0] rd_dm;
	wire we_dmM;
`endif

//mips mips (
//`ifdef SIM
//.rd1(rd1),
//.a_ctrl (a_ctrl),
//.alu_pb (alu_pb),
//.rT0(rT0),
//`endif
//.clk            (clk),
//.rst            (rst),
//.ra3            (ra3),
//.instr          (instr),
//.rd_dm          (soc_rd),
//.we_dmM          (we_dm),
//.pc_current     (pc_current),
//.alu_out        (alu_out),
//.wd_dm          (wd_dm)
//.rd3            (rd3)
//);


mips MIPS(
	`ifdef SIM
		.lwstall       (lwstall),
		.branchstall   (branchstall),
		.forwardAE                   (forwardAE),
		.forwardBE                   (forwardBE),
		.forwardAD                   (forwardAD),
		.forwardBD                   (forwardBD),
		.stallF                      (stallF),
		.stallD                      (stallD),
		.flushE                      (flushE),
		.rsD                         (rsD),
		.rtD                         (rtD),
		.rdD                         (rdD),
		.rtE                         (rtE),
		.we_regM                    (we_regM),
		.we_regW                    (we_regW),
		.rf_waM                      (rf_waM),
		.rf_waW                      (rf_waW),
		.jal_wd_selM                 (jal_wd_selM),
		.jal_wd_selE                 (jal_wd_selE),
		.branch                      (branch),
		.muldiv_enE                  (muldiv_enE),
		.muldiv_enE_qual             (muldiv_enE_qual),
		.hilo_read_done              (hilo_read_done),
		.rAT                         (rAT),
		.rV0                         (rV0),
		.rV1                         (rV1),
		.rA0                         (rA0),
		.rA1                         (rA1),
		.rA2                         (rA2),
		.rT0                         (rT0),
		.rT1                         (rT1),
		.rT2                         (rT2),
		.rT3                         (rT3),
		.rT4                         (rT4),
		.rT5                         (rT5),
		.rT6                         (rT6),
		.rT7                         (rT7),
		.rS0                         (rS0),
		.rS1                         (rS1),
		.rS2                         (rS2),
		.rS3                         (rS3),
		.rS4                         (rS4),
		.rS5                         (rS5),
		.rS6                         (rS6),
		.rS7                         (rS7),
		.rT8                         (rT8),
		.rT9                         (rT9),
		.rK0                         (rK0),
		.rK1                         (rK1),
		.rGP                         (rGP),
		.rSP                         (rSP),
		.rFP                         (rFP),
		.rRA                         (rRA),
		.wd_rfW                      (wd_rfW),
		.branchE                     (branchE),
		.jumpE                       (jumpE),
		.alu_src_immE                (alu_src_immE),
		.we_regE                     (we_regE),
		.hilo_mov_opE                (hilo_mov_opE),
		.hilo_mov_opM                (hilo_mov_opM),
		.hilo_mov_opW                (hilo_mov_opW),
		.hi0_lo1_selE                (hi0_lo1_selE),
		.mul0_div1_selE              (mul0_div1_selE),
		.mul0_div1_selM              (mul0_div1_selM),
		.dm_load_opE                 (dm_load_opE),
		.wr_ra_jalE                  (wr_ra_jalE),
		.jr_selE                     (jr_selE),
		.wr_ra_instrE                (wr_ra_instrE),
		.slt_opE                     (slt_opE),
		.arith_opE                   (arith_opE),
		.alu_ctrlE                   (alu_ctrlE),
		.signExt0_zeroExt1E          (signExt0_zeroExt1E),
		.dm_load_opM                 (dm_load_opM),
		.dm_load_opW                 (dm_load_opW),
		.jal_wd_selW                 (jal_wd_selW),
		.mul0_div1_selW              (mul0_div1_selW),
		.pc_plus4D                   (pc_plus4D),
		.pc_plus4E                   (pc_plus4E),
		.zero                        (zero),
		.equalsD                     (equalsD),
		.wd_hiloW                    (wd_hiloW),
		.wd_alu_dmW                  (wd_alu_dmW),
		.rd1_outE                    (rd1_outE),
		.rd2_outE                    (rd2_outE),
		.sext_immE                   (sext_immE),
		.rsE                         (rsE),
		.rdE                         (rdE),
		.shamtE                      (shamtE),
		.rf_waE                      (rf_waE),
		.alu_outE                    (alu_outE),
		.alu_outM                    (alu_outM),
		.alu_outW                    (alu_outW),
		.hilo_mux_outM               (hilo_mux_outM),
		.hilo_mux_outE               (hilo_mux_outE),
		.pc_plus8M                   (pc_plus8M),
		.pc_plus8W                   (pc_plus8W),
		.rd_dmW                      (rd_dmW),
		.hilo_mux_outW               (hilo_mux_outW),
		.pc_plus8E                   (pc_plus8E),
		.alu_pb                      (alu_pb),
		.a_ctrl                      (a_ctrl),
		.rd1                         (rd1),
		.instrD                      (instrD),
		.arith_overflow              (arith_overflow),
		.rd3                         (rd3),
		.ra3                         (ra3),
	`endif
	.clk                         (clk),
	.rst                         (rst),
	.instr                       (instr),
	.rd_dm                       (soc_rd),
	.we_dmM                      (we_dmM),
	.pc_current                  (pc_current),
	.alu_out                     (alu_out),
	.wd_dm                       (wd_dm)
);
	imem imem (
		.a              (pc_current[7:2]),
		.y              (instr)
	);

	dmem dmem (
		.clk            (clk),
		.we             (we_dmM),
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
