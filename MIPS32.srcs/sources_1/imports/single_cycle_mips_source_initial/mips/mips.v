`timescale 1ns / 1ps

module mips (
`ifdef SIM
         wire muldiv_enE,
         wire     muldiv_enE_qual,
         wire hilo_read_done,
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

         output wire		hilo_sel,
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

         output wire [31:0] alu_pb,
         output wire [2:0] a_ctrl,
         output wire [31:0] rd1,
         wire [31:0] instrD,


`endif
         input  wire        clk,
         input  wire        rst,
         input  wire [4:0]  ra3,
         input  wire [31:0] instr,
         input  wire [31:0] rd_dm,
         output wire        we_dm,
         output wire [31:0] pc_current,
         output wire [31:0] alu_out,
         output wire [31:0] wd_dm,
         output wire [31:0] rd3

       );


wire       branch;
wire       jump;
wire       we_reg;
wire [2:0] alu_ctrl;

`ifdef SIM
assign a_ctrl = alu_ctrl;
`endif

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
`ifndef SIM
        wire [31:0] instrD;
`endif

datapath dp (
`ifdef SIM
           .muldiv_enE                  (muldiv_enE),
           .muldiv_enE_qual             (muldiv_enE_qual),
           .hilo_read_done              (hilo_read_done),
           .rd1 (rd1),
           .alu_pb_sim (alu_pb),
           .wd_rfW                      (wd_rfW),
           .hilo_sel                    (hilo_sel),
           .branchE                     (branchE),
           .jumpE                       (jumpE),
           .alu_src_immE                (alu_src_immE),
           .we_regE                     (we_regE),
           .we_regM                     (we_regM),
           .we_regW                     (we_regW),
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
           .jal_wd_selE                 (jal_wd_selE),
           .jal_wd_selM                 (jal_wd_selM),
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
           .rtE                         (rtE),
           .rdE                         (rdE),
           .shamtE                      (shamtE),
           .rf_waE                      (rf_waE),
           .rf_waM                      (rf_waM),
           .rf_waW                      (rf_waW),
           .alu_outE                    (alu_outE),
           .alu_outM                    (alu_outM),
           .alu_outW                    (alu_outW),
           .wd_dmM                      (wd_dmM),
           .hilo_mux_outM               (hilo_mux_outM),
           .hilo_mux_outE               (hilo_mux_outE),
           .pc_plus8M                   (pc_plus8M),
           .pc_plus8W                   (pc_plus8W),
           .rd_dmW                      (rd_dmW),
           .hilo_mux_outW               (hilo_mux_outW),
           .pc_plus8E                   (pc_plus8E),
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
		   .muldiv_op              (muldiv_op)

         );

controlunit cu (
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
              .muldiv_reg_sel          (muldiv_reg_sel),
              .alu_out_sel             (alu_out_sel),
              .hilo_shift_sel          (hilo_shift_sel),
              .alu_src_imm             (alu_src_imm),
              .wr_ra_jal               (wr_ra_jal),
              .wr_ra_instr             (wr_ra_instr),
              .jal_wd_sel              (jal_wd_sel),
              .dm_load_op              (dm_load_op),
              .alu_ctrl                (alu_ctrl),
			  .muldiv_op              (muldiv_op),
              .signExt0_zeroExt1       (signExt0_zeroExt1)
            );
endmodule
