`timescale 1ns / 1ps

module tb_system();

	wire        pc_src;
	wire [31:0] alu_src_a;
	wire [31:0] alu_src_b;
	wire        lwstall;
	wire        branchstall;
	wire [1:0] forwardAE;
	wire [1:0] forwardBE;
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
	wire [4:0] rf_waM;
	wire [4:0] rf_waW;
	wire  jal_wd_selM;
	wire  jal_wd_selE;
	wire  branch;
	wire  muldiv_enE;
	wire  muldiv_enE_qual;
	wire  hilo_read_done;
	wire [31:0] rAT;
	wire [31:0] rV0;
	wire [31:0] rV1;
	wire [31:0] rA0;
	wire [31:0] rA1;
	wire [31:0] rA2;
	wire [31:0] rT0;
	wire [31:0] rT1;
	wire [31:0] rT2;
	wire [31:0] rT3;
	wire [31:0] rT4;
	wire [31:0] rT5;
	wire [31:0] rT6;
	wire [31:0] rT7;
	wire [31:0] rS0;
	wire [31:0] rS1;
	wire [31:0] rS2;
	wire [31:0] rS3;
	wire [31:0] rS4;
	wire [31:0] rS5;
	wire [31:0] rS6;
	wire [31:0] rS7;
	wire [31:0] rT8;
	wire [31:0] rT9;
	wire [31:0] rK0;
	wire [31:0] rK1;
	wire [31:0] rGP;
	wire [31:0] rSP;
	wire [31:0] rFP;
	wire [31:0] rRA;
	wire [31:0] wd_rfW;
	wire  branchE;
	wire  jumpE;
	wire  alu_src_immE;
	wire  we_regE;
	wire  hilo_mov_opE;
	wire  hilo_mov_opM;
	wire  hilo_mov_opW;
	wire  hi0_lo1_selE;
	wire  mul0_div1_selE;
	wire  mul0_div1_selM;
	wire  dm_load_opE;
	wire  wr_ra_jalE;
	wire  jr_selE;
	wire  wr_ra_instrE;
	wire  slt_opE;
	wire  arith_opE;
	wire [2:0] alu_ctrlE;
	wire  signExt0_zeroExt1E;
	wire  dm_load_opM;
	wire  dm_load_opW;
	wire  jal_wd_selW;
	wire  mul0_div1_selW;
	wire [31:0] pc_plus4D;
	wire [31:0] pc_plus4E;
	wire  zero;
	wire  equalsD;
	wire [31:0] wd_hiloW;
	wire [31:0] wd_alu_dmW;
	wire [31:0] rd1_outE;
	wire [31:0] rd2_outE;
	wire [31:0] sext_immE;
	wire [4:0] rdE;
	wire [4:0] shamtE;
	wire [4:0] rf_waE;
	wire [31:0] alu_outE;
	wire [31:0] alu_outM;
	wire [31:0] alu_outW;
	wire [31:0] hilo_mux_outM;
	wire [31:0] hilo_mux_outE;
	wire [31:0] pc_plus8M;
	wire [31:0] pc_plus8W;
	wire [31:0] rd_dmW;
	wire [31:0] hilo_mux_outW;
	wire [31:0] pc_plus8E;
	wire [31:0] alu_pb;
	wire [2:0] a_ctrl;
	wire [31:0] rd1;
	wire [31:0] instrD;
	wire  arith_overflow;
	wire [31:0] instr;
	wire [31:0] alu_out;
	wire [31:0] soc_rd;
	wire [31:0] wd_dm;
	wire  we_dmM;
	wire [31:0] rd_dm;
	wire [4:0] ra3;
	wire [31:0] rd3;
	reg  clk = 0;
	reg  rst = 0;
	reg [31:0] gpI1 = 0;
	//reg [31:0] gpI2 = 0;
	wire [31:0] gpI2;
	wire [31:0] gpO2;
	wire [31:0] gpO1;
	wire [31:0] pc_current;

	assign gpI2 = gpO1;
	system DUT (
		.alu_src_a                 (alu_src_a),
		.alu_src_b                 (alu_src_b),
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
		.rsE                         (rsE),
		.rtE                         (rtE),
		.we_regM                     (we_regM),
		.we_regW                     (we_regW),
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
		.instr                       (instr),
		.alu_out                     (alu_out),
		.soc_rd                      (soc_rd),
		.wd_dm                       (wd_dm),
		.we_dmM                      (we_dmM),
		.rd_dm                       (rd_dm),
		.ra3                         (ra3),
		.rd3                         (rd3),
		.clk                         (clk),
		.rst                         (rst),
		.gpI1                        (gpI1),
		.gpI2                        (gpI2),
		.gpO2                        (gpO2),
		.gpO1                        (gpO1),
		.pc_current                  (pc_current),
		.pc_src                    (pc_src),
		.lwstall       (lwstall),
		.branchstall   (branchstall)
	);




	task tick;
		begin
			clk = 1'b0;
			#5;
			clk = 1'b1;
			#5;
		end
	endtask




	task reset;
		begin
			rst = 1'b0;
			#5;
			rst = 1'b1;
			#5;
			rst = 1'b0;
			#5;
			//rst <= #5 1'b0;
			//rst <= #5 1'b1;
			//rst <= #5 1'b0;
		end
	endtask


	integer errors = 0;
	integer exp_factorial = 0;
	integer test;


	function automatic integer fact;
		// Input Params
		input integer n;
		// Local Vars
		integer result, count;
		begin //routine
			result = 1;
			if(n <= 1)
			begin
				fact = 1;
			end
			else
			begin
				for(count = n; count > 0; count = count - 1)
				begin
					result = result * count;
				end
				fact = result;
			end //end else
		end //end routine
	endfunction
	




	integer i = 0;

	wire fact_done; 
	assign fact_done = (pc_current == 32'h34) ? 1'b1 : 1'b0;

	initial
	begin
		$monitor("n = %d; Expected: %d; Result: %d; Time: %t", i, exp_factorial, gpO2, $time);
		gpI1 = i;
		test = i;
		#1;
		reset;
		forever #5 clk = ~clk;
	end

	always @(posedge fact_done) ->done;

	event done;

	always @(done)
	begin
		exp_factorial = fact(i);
		#1;
		i = i + 1;
		gpI1 = i;
		test = i;
		if(gpO2 != exp_factorial) errors = errors + 1;
	end

	always @(done)
	begin
		if(i == 13) $finish;
		reset;
	end

endmodule
