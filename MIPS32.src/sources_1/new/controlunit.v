`timescale 1ns / 1ps

module controlunit (
         input  wire [5:0]  opcode,
         input  wire [5:0]  funct,
         output wire        branch,
         output wire        jump,
         output wire        we_reg,
         output wire        we_dm,
         output wire  slt_op,
         output wire  arith_op,
         output wire  hilo_mov_op,
         output wire  hi0_lo1_sel,
         output wire  mul0_div1_sel,
         output wire  alu_src_imm,
         output wire  wr_ra_jal,
         output wire  wr_ra_instr,
         output wire  jal_wd_sel,
         output wire  dm_load_op,
         output wire  jr_sel,
         output wire  muldiv_op,
         output  wire        signExt0_zeroExt1,
         output wire [2:0]  alu_ctrl
       );


wire [2:0] alu_op;
wire  r_type;

maindec md (
          .opcode               (opcode),
          .branch               (branch),
          .jump                 (jump),
          .we_reg               (we_reg),
          .alu_src_imm          (alu_src_imm),
          .we_dm                (we_dm),
          .alu_op               (alu_op),
          .wr_ra_jal            (wr_ra_jal),
          .wr_ra_instr          (wr_ra_instr),
          .jal_wd_sel           (jal_wd_sel),
          .dm_load_op           (dm_load_op),
          .r_type               (r_type)
        );



auxdec ad (
         .alu_op                  (alu_op),
         .funct                   (funct),
         .r_type                  (r_type),

         .muldiv_op               (muldiv_op),
         .jr_sel			      (jr_sel),
         .alu_ctrl                (alu_ctrl),
         .slt_op                  (slt_op),
         .arith_op                (arith_op),
         .hilo_mov_op             (hilo_mov_op),
         .hi0_lo1_sel             (hi0_lo1_sel),
         .mul0_div1_sel           (mul0_div1_sel),
         .signExt0_zeroExt1       (signExt0_zeroExt1)
       );

endmodule
