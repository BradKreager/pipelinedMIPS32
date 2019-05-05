`timescale 1ns / 1ps

module datapath (
	`ifdef SIM
		output wire muldiv_enE,
		output reg muldiv_enE_qual,
		output reg hilo_read_done,
		output wire [31:0] wd_rfW,
		output wire [31:0] rd1,
		output wire [31:0] alu_pb_sim,

		output wire		   branchE,

		output wire		   jumpE,

		output wire		   alu_src_immE,

		output wire		   we_regE,
		output wire		   we_regM,
		output wire		   we_regW,


		output wire		   hilo_mov_opE,
		output wire		   hilo_mov_opM,
		output wire		   hilo_mov_opW,

		output wire		   hi0_lo1_selE,

		output wire		   mul0_div1_selE,
		output wire		   mul0_div1_selM,

		output wire		   dm_load_opE,

		output wire		   wr_ra_jalE,

		output wire		   jr_selE,

		output wire		   wr_ra_instrE,

		output wire		   slt_opE,

		output wire		   arith_opE,

		output wire [2:0]	   alu_ctrlE,

		output wire		   signExt0_zeroExt1E,

		output wire		   dm_load_opM,
		output wire		   dm_load_opW,

		output wire		   jal_wd_selE,
		output wire		   jal_wd_selM,
		output wire		   jal_wd_selW,

		output wire			mul0_div1_selW,

		// datapath
		output wire [31:0]		pc_plus4D,
		output wire [31:0] pc_plus4E,

		output wire        zero,
		output wire	    equalsD,

		output wire [31:0]		wd_hiloW,

		output wire [31:0]		wd_alu_dmW,

		output wire [31:0] rd1_outE,
		output wire [31:0] rd2_outE,
		output wire [31:0] sext_immE,

		output wire [4:0] rsE,
		output wire [4:0] rtE,
		output wire [4:0] rdE,
		output wire [4:0] shamtE,


		output wire [4:0] rf_waE,
		output wire [4:0] rf_waM,
		output wire [4:0] rf_waW,

		output wire [31:0] alu_outE,
		output wire [31:0] alu_outM,
		output wire [31:0] alu_outW,
		output wire [31:0] wd_dmM,
		output wire [31:0] hilo_mux_outM,
		output wire [31:0] hilo_mux_outE,
		output wire [31:0] pc_plus8M,
		output wire [31:0] pc_plus8W,

		output wire [31:0] rd_dmW,
		output wire [31:0] hilo_mux_outW,

		output wire [31:0] pc_plus8E,

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
	`endif
	input  wire        clk,
	input  wire        rst,

	input  wire        branch,
	input  wire        jump,

	input  wire        we_reg,
	input  wire        alu_src_imm,

	input  wire        hilo_mov_op,
	input  wire	       hi0_lo1_sel,
	input  wire    	   mul0_div1_sel,

	input  wire 	   dm_load_op,
	input  wire       muldiv_op,

	input  wire 	   wr_ra_jal,
	input  wire 	   jal_wd_sel,
	input  wire        jr_sel,

	input  wire	       wr_ra_instr,

	input  wire        slt_op,
	input  wire        arith_op,

	input  wire [2:0]  alu_ctrl,
	input  wire [4:0]  ra3,
	input  wire [31:0] instr,
	input  wire [31:0] rd_dm,
	input  wire        signExt0_zeroExt1,
	input  wire        we_dm,


	output  wire       we_dmM,
	output  wire [31:0] instrD,
	output wire        arith_overflow,
	output wire [31:0] pc_current,
	output wire [31:0] alu_out,
	output wire [31:0] wd_dm,
	output wire [31:0] rd3
);


	assign alu_out = alu_outM;
	wire [4:0]  rf_wa;
	wire [4:0]  jal_wa;
	wire [4:0]  instr_wa;

	wire        pc_src;
	wire [31:0] pc_plus4;
	wire [31:0] pc_pre;
	wire [31:0] pc_next;
	wire [31:0] sext_imm;


	wire [31:0] ba;
	wire [31:0] bta;
	wire [31:0] jta;

	wire [31:0] rd1_out;
	wire [31:0] rd2_out;


	`ifdef SIM

		assign alu_pb_sim = alu_pb;
	`endif


	wire [31:0] alu_pb;
	wire [31:0] jr_pc_next;


	wire [31:0] muldiv_highE;
	wire [31:0] muldiv_lowE;
	wire [31:0] muldiv_high_regE;
	wire [31:0] muldiv_low_regE;


	wire we_dmE;

	`ifndef SIM
		wire muldiv_enE;

		reg    hilo_read_done,
		muldiv_enE_qual;

		/* Pipeline signals */

		// control signals
		wire [31:0] wd_rfW;

		wire		   branchE;

		wire		   jumpE;

		wire		   alu_src_immE;

		wire		   we_regE;
		wire		   we_regM;
		wire		   we_regW;


		wire		   hilo_mov_opE;
		wire		   hilo_mov_opM;
		wire		   hilo_mov_opW;

		wire		   hi0_lo1_selE;

		wire		   mul0_div1_selE;
		wire		   mul0_div1_selM;

		wire		   dm_load_opE;

		wire		   wr_ra_jalE;

		wire		   jr_selE;

		wire		   wr_ra_instrE;

		wire		   slt_opE;

		wire		   arith_opE;

		wire [2:0]	   alu_ctrlE;

		wire		   signExt0_zeroExt1E;

		wire		   dm_load_opM;
		wire		   dm_load_opW;

		wire		   jal_wd_selE;
		wire		   jal_wd_selM;
		wire		   jal_wd_selW;

		wire			mul0_div1_selW;

		// datapath
		wire [31:0]		pc_plus4D;
		wire [31:0] pc_plus4E;

		wire        zero;
		wire	    equalsD;

		wire [31:0]		wd_hiloW;

		wire [31:0]		wd_alu_dmW;

		wire [31:0] rd1_outE,
		rd2_outE,
		sext_immE;

		wire [4:0] rsE,
		rtE,
		rdE,
		shamtE;


		wire [4:0] rf_waE,
		rf_waM,
		rf_waW;

		wire [31:0] alu_outE,
		alu_outM,
		alu_outW,
		wd_dmM,
		hilo_mux_outM,
		hilo_mux_outE,
		pc_plus8M,
		pc_plus8W;

		wire [31:0] rd_dmW,
		hilo_mux_outW;

		wire [31:0] pc_plus8E;
		/* Pipeline signals end */
	`endif

	assign rd1 = rd1_out;

	assign equalsD = (rd1_out == rd2_out) ? 1'b1 : 1'b0;
	assign pc_src = branch & equalsD;
	assign ba = {sext_imm[29:0], 2'b00};
	assign jta = {pc_plus4D[31:28], instrD[25:0], 2'b00};
	assign wd_dm = wd_dmM;

	always @(posedge clk, posedge rst)
	begin
		if(rst | hilo_mov_opE)
		begin
			hilo_read_done <= 1'b1;
			muldiv_enE_qual <= 1'b1;
		end
		else
		begin
			if(muldiv_enE)
			begin
				hilo_read_done <= 1'b0;
				muldiv_enE_qual <= muldiv_enE_qual;
			end
			else
			begin
				hilo_read_done <= hilo_read_done;
				muldiv_enE_qual <= hilo_read_done;
			end
		end

	end

	assign muldiv_enE = muldiv_op;

	/* --- Pipeline (control signals) --- */
	wire [18:0] csSigsE;
	wire [18:0]	   csSigsD;

	assign csSigsD =
		{
			branch,
			jump,
			we_reg,
			alu_src_imm,
			hilo_mov_op,
			hi0_lo1_sel,
			mul0_div1_sel,
			dm_load_op,
			wr_ra_jal,
			jal_wd_sel,
			jr_sel,
			wr_ra_instr,
			slt_op,
			arith_op,
			alu_ctrl,
			signExt0_zeroExt1,
			we_dm
		};

	assign
	{
		branchE,
		jumpE,
		we_regE,
		alu_src_immE,
		hilo_mov_opE,
		hi0_lo1_selE,
		mul0_div1_selE,
		dm_load_opE,
		wr_ra_jalE,
		jal_wd_selE,
		jr_selE,
		wr_ra_instrE,
		slt_opE,
		arith_opE,
		alu_ctrlE,
		signExt0_zeroExt1E,
		we_dmE
	}
		= csSigsE;

	dreg_sync_rst #(19)csRegE (
		.clk            (clk),
		.rst            (rst),
		.d              (csSigsD),
		.q              (csSigsE)
	);




	dreg_sync_rst #(5) csRegM (
		.clk            (clk),
		.rst            (1'b0),
		.d              ({we_regE, hilo_mov_opE, dm_load_opE, jal_wd_selE, we_dmE}),
		.q              ({we_regM, hilo_mov_opM, dm_load_opM, jal_wd_selM, we_dmM})
	);





	dreg_sync_rst #(4)csRegW (
		.clk            (clk),
		.rst            (1'b0),
		.d              ({we_regM, hilo_mov_opM, dm_load_opM, jal_wd_selM}),
		.q              ({we_regW, hilo_mov_opW, dm_load_opW, jal_wd_selW})
	);



	/* --- Pipeline (data) --- */
	dreg_sync_rst #(32) dpRegF(
		.clk            (clk),
		.rst            (rst),
		.d              (pc_pre),
		.q              (pc_current)
	);



	dreg_sync_rst #(64)dpRegD(
		.clk            (clk),
		.rst            (rst),
		.d              ({instr, pc_plus4}),
		.q              ({instrD, pc_plus4D})
	);


	dreg_sync_rst #(148)dpRegE (
		.clk            (clk),
		.rst            (rst),
		.d              ({instrD[25:21], instrD[20:16], instrD[15:11], sext_imm, rd1_out, rd2_out, instrD[10:6], pc_plus4D}),
		.q              ({rsE, rtE, rdE, sext_immE, rd1_outE, rd2_outE, shamtE, pc_plus4E})
	);




	dreg_sync_rst #(133)dpRegM (
		.clk            (clk),
		.rst            (1'b0),
		.d              ({alu_outE, rd2_outE, rf_waE, hilo_mux_outE, pc_plus8E}),
		.q              ({alu_outM, wd_dmM, rf_waM, hilo_mux_outM, pc_plus8M})
	);


	dreg_sync_rst #(133)dpRegW (
		.clk            (clk),
		.rst            (1'b0),
		.d              ({rd_dm, alu_outM, rf_waM, hilo_mux_outM, pc_plus8M}),
		.q              ({rd_dmW, alu_outW, rf_waW, hilo_mux_outW, pc_plus8W})
	);






	/* --- PC Logic --- */

	adder pc_plus_4 (
		.a              (pc_current),
		.b              (32'd4),
		.y              (pc_plus4)
	);

	adder pc_plus_br (
		.a              (pc_plus4D),
		.b              (ba),
		.y              (bta)
	);

	mux2 #(32) pc_src_mux (
		.sel            (pc_src),
		.a              (pc_next),
		.b              (bta),
		.y              (pc_pre)
	);


	mux2 #(32) pc_jmp_mux (
		.sel            (jump),
		.a              (jr_pc_next),
		.b              (jta),
		.y              (pc_next)
	);

	mux2 #(32) jr_mux (
		.sel            (jr_sel),
		.a              (pc_plus4),
		.b              (rd1_out),
		.y              (jr_pc_next)
	);






	/* --- RF Logic --- */
	mux2 #(5) instr_wa_mux (
		.sel            (wr_ra_instrE),
		.a              (rdE),
		.b              (rtE),
		.y              (instr_wa)
	);

	mux2 #(5) jal_wa_mux (
		.sel            (wr_ra_jalE),
		.a              (5'd0),
		.b              (5'd31),
		.y              (jal_wa)
	);
	mux2 #(5) rf_wa_mux (
		.sel            (jumpE),
		.a              (instr_wa),
		.b              (jal_wa),
		.y              (rf_waE)
	);

	regfile rf (
		`ifdef SIM
			.rAT          (rAT),
			.rV0          (rV0),
			.rV1          (rV1),
			.rA0          (rA0),
			.rA1          (rA1),
			.rA2          (rA2),
			.rT0          (rT0),
			.rT1          (rT1),
			.rT2          (rT2),
			.rT3          (rT3),
			.rT4          (rT4),
			.rT5          (rT5),
			.rT6          (rT6),
			.rT7          (rT7),
			.rS0          (rS0),
			.rS1          (rS1),
			.rS2          (rS2),
			.rS3          (rS3),
			.rS4          (rS4),
			.rS5          (rS5),
			.rS6          (rS6),
			.rS7          (rS7),
			.rT8          (rT8),
			.rT9          (rT9),
			.rK0          (rK0),
			.rK1          (rK1),
			.rGP          (rGP),
			.rSP          (rSP),
			.rFP          (rFP),
			.rRA          (rRA),
		`endif
		.clk            (clk),
		.we             (we_regW),
		.ra1            (instrD[25:21]),
		.ra2            (instrD[20:16]),
		.ra3            (ra3),
		.wa             (rf_waW),
		.wd             (wd_rfW),
		.rd1            (rd1_out),
		.rd2            (rd2_out),
		.rd3            (rd3)
	);

		ext_unit ext_imm (
			.ext_sign0_zero1  (signExt0_zeroExt1),
			.a                (instrD[15:0]),
			.y                (sext_imm)
		);

		// --- ALU Logic --- //

		// TODO: add forwarding to alu inputs and wd_dm

		mux2 #(32) alu_pb_mux (
			.sel            (alu_src_immE),
			.a              (rd2_outE),
			.b              (sext_immE),
			.y              (alu_pb)
		);


		alu alu (
			.op                (alu_ctrlE),
			.a                 (rd1_outE),
			.b                 (alu_pb),
			.shamt             (shamtE),
			.slt_op            (slt_opE),
			.arith_op          (arith_opE),
			.zero              (zero),
			.overflow          (arith_overflow),
			.y                 (alu_outE)
		);

		// --- MULTIPLIER/DIVIDER R-TYPE Logic --- //

		mul_div_unit
		mul_div(
			.inA                    (rd1_outE),
			.inB                    (rd2_outE),
			// .clk					(clk),
			.mul0_div1_sel          (mul0_div1_selE),
			.outH                   (muldiv_highE),
			.outL                   (muldiv_lowE)
		);


		dreg_sync_rst_en high_reg (
			.clk            (clk),
			.rst            (rst),
			.en				        (muldiv_enE_qual),
			.d              (muldiv_highE),
			.q              (muldiv_high_regE)
		);


		dreg_sync_rst_en low_reg (
			.clk            (clk),
			.rst            (rst),
			.en				        (muldiv_enE_qual),
			.d              (muldiv_lowE),
			.q              (muldiv_low_regE)
		);

		mux2 #(32) hilo_data_mux (
			.sel            (hi0_lo1_selE),
			.a              (muldiv_high_regE),
			.b              (muldiv_low_regE),
			.y              (hilo_mux_outE)
		);

		// --- MEM Logic --- //
		adder pc_plus_8 (
			.a              (pc_plus4E),
			.b              (32'd4),
			.y              (pc_plus8E)
		);

		mux2 #(32) wd_jal_mux (
			.sel            (jal_wd_selW),
			.a              (wd_hiloW),
			.b              (pc_plus8W),
			.y              (wd_rfW)
		);

		mux2 #(32) wd_hilo_mux (
			.sel            (hilo_mov_opW),
			.a              (wd_alu_dmW),
			.b              (hilo_mux_outW),
			.y              (wd_hiloW)
		);

		mux2 #(32) alu_dm_data_mux (
			.sel            (dm_load_opW),
			.a              (alu_outW),
			.b              (rd_dmW),
			.y              (wd_alu_dmW)
		);
endmodule
