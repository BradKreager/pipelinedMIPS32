`timescale 1ns / 1ps

module mips (
`ifdef SIM
         output wire [31:0] rd1,
         output wire [2:0] a_ctrl,
         output wire [31:0] alu_pb,
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

datapath dp (
`ifdef SIM
           .rd1 (rd1),
           .alu_pb_sim (alu_pb),
`endif
           .clk                    (clk),
           .rst                    (rst),
           .branch                 (branch),
           .jump                   (jump),
           .we_reg                 (we_reg),
           .alu_src_imm            (alu_src_imm),
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
           .arith_op                (arith_op)

         );

controlunit cu (
              .opcode                  (instr[31:26]),
              .funct                   (instr[5:0]),

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
              .signExt0_zeroExt1       (signExt0_zeroExt1)
            );
endmodule
