`timescale 1ns / 1ps

module mips (
	input  wire        clk,
	input  wire        rst,
	input  wire [4:0]  ra3,
	input  wire [31:0] instr,
	input  wire [31:0] rd_dm,
	output wire        we_dmM,
	output wire [31:0] pc_current,
	output wire [31:0] alu_out,
	output wire [31:0] wd_dm,
	output wire [31:0] rd3
);


	wire        we_dm;
	wire       jump;
	wire       we_reg;
	wire [2:0] alu_ctrl;



	wire signExt0_zeroExt1;

	wire  hilo_mov_op;
	wire  hi0_lo1_sel;
	wire  mul0_div1_sel;
	wire  dm_load_op;
	wire  wr_ra_jal;
	wire  jal_wd_sel;
	wire  jr_sel;
	wire  wr_ra_instr;
	wire  slt_op;
	wire  muldiv_op;
	wire [1:0]  forwardAE;
	wire [1:0]  forwardBE;
	wire  forwardAD;
	wire  forwardBD;
	wire  stallF;
	wire  stallD;
	wire  flushE;
	wire [4:0] rsD;
	wire [4:0] rtD;
	wire [4:0] rdD;
	wire [4:0] rsE;
	wire [4:0] rtE;
	wire  we_regM;
	wire  we_regW;
	wire [4:0] rf_waE;
	wire [4:0] rf_waM;
	wire [4:0] rf_waW;
	wire  jal_wd_selE;
	wire  jal_wd_selM;
	wire  branch;
	wire [31:0] instrD;
	wire arith_overflow;

	datapath dp (

		.dm_load_opE                 (dm_load_opE),
		.dm_load_opM                 (dm_load_opM),
		.clk                    (clk),
		.rst                    (rst),
		.branch                 (branch),
		.jump                   (jump),
		.we_reg                 (we_reg),
		.alu_src_imm                (alu_src_imm),
		.hilo_mov_op            (hilo_mov_op),
		.hi0_lo1_sel            (hi0_lo1_sel),
		.mul0_div1_sel          (mul0_div1_sel),
		.dm_load_op             (dm_load_op),
		.wr_ra_jal              (wr_ra_jal),
		.jal_wd_sel             (jal_wd_sel),
		.jr_sel                 (jr_sel),
		.wr_ra_instr            (wr_ra_instr),
		.alu_ctrl               (alu_ctrl),
		.ra3                    (ra3),
		.instr                  (instr),
		.rd_dm                  (rd_dm),
		.pc_current             (pc_current),
		.alu_out                (alu_out),
		.wd_dm                  (wd_dm),
		.rd3                    (rd3),
		.signExt0_zeroExt1       (signExt0_zeroExt1),
		.slt_op                 (slt_op),
		.arith_op                (arith_op),
		.instrD                 (instrD),
		.muldiv_op              (muldiv_op),
		.arith_overflow         (arith_overflow),
		.we_dm                  (we_dm),
		.we_dmM                 (we_dmM),
		.forwardAE            (forwardAE),
		.forwardBE            (forwardBE),
		.forwardAD            (forwardAD),
		.forwardBD            (forwardBD),
		.stallF               (stallF),
		.stallD               (stallD),
		.flushE               (flushE),
		.rsD                  (rsD),
		.rtD                  (rtD),
		.rdD                  (rdD),
		.rsE                  (rsE),
		.rtE                  (rtE),
		.we_regE                     (we_regE),
		.we_regM              (we_regM),
		.we_regW              (we_regW),
		.rf_waE                      (rf_waE),
		.rf_waM               (rf_waM),
		.rf_waW               (rf_waW)
	);

	controlunit cu(
		.opcode                  (instrD[31:26]),
		.funct                   (instrD[5:0]),
		.jr_sel                 (jr_sel),
		.branch                  (branch),
		.jump                    (jump),
		.we_reg                  (we_reg),
		.we_dm                   (we_dm),
		.slt_op                  (slt_op),
		.arith_op                (arith_op),
		.hilo_mov_op             (hilo_mov_op),
		.hi0_lo1_sel             (hi0_lo1_sel),
		.mul0_div1_sel           (mul0_div1_sel),
		.alu_src_imm             (alu_src_imm),
		.wr_ra_jal               (wr_ra_jal),
		.wr_ra_instr             (wr_ra_instr),
		.jal_wd_sel              (jal_wd_sel),
		.dm_load_op              (dm_load_op),
		.alu_ctrl                (alu_ctrl),
		.muldiv_op              (muldiv_op),
		.signExt0_zeroExt1       (signExt0_zeroExt1)
	);



	hazard_monitor HAZ_UNIT(

		.forwardAE            (forwardAE),
		.forwardBE            (forwardBE),
		.forwardAD            (forwardAD),
		.forwardBD            (forwardBD),
		.stallF               (stallF),
		.stallD               (stallD),
		.flushE               (flushE),
		.rsD                  (rsD),
		.rtD                  (rtD),
		.rdD                  (rdD),
		.rsE                  (rsE),
		.rtE                  (rtE),
		.we_regE              (we_regE),
		.we_regM              (we_regM),
		.we_regW              (we_regW),
		.rf_waE                      (rf_waE),
		.rf_waM               (rf_waM),
		.rf_waW               (rf_waW),
		.dm_load_opE                 (dm_load_opE),
		.dm_load_opM                 (dm_load_opM),
		.branch               (branch)
	);
endmodule
