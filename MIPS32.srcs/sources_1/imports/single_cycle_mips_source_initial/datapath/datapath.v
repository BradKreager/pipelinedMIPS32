`timescale 1ns / 1ps

module datapath (
`ifdef SIM
         output wire [31:0] rd1,
         output wire [31:0] alu_pb_sim,
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


         output wire        arith_overflow,
         output wire [31:0] pc_current,
         output wire [31:0] alu_out,
         output wire [31:0] wd_dm,
         output wire [31:0] rd3
       );


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
wire [31:0] wd_rf;
wire [31:0] jr_pc_next;


wire [31:0] muldiv_high;
wire [31:0] muldiv_low;
wire [31:0] muldiv_high_reg;
wire [31:0] muldiv_low_reg;




wire		hilo_sel;
wire [31:0] hilo_mux_out;
wire [31:0] wd_hilo;
wire [31:0] wd_alu_dm;
wire        zero;


assign rd1 = rd1_out;


assign pc_src = branch & zero;
assign ba = {sext_imm[29:0], 2'b00};
assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
assign wd_dm = rd2_out;

/* --- PC Logic --- */

dreg pc_reg (
       .clk            (clk),
       .rst            (rst),
       .d              (jr_pc_next),
       .q              (pc_current)
     );

adder pc_plus_4 (
        .a              (pc_current),
        .b              (32'd4),
        .y              (pc_plus4)
      );

adder pc_plus_br (
        .a              (pc_plus4),
        .b              (ba),
        .y              (bta)
      );

mux2 #(32) pc_src_mux (
       .sel            (pc_src),
       .a              (pc_plus4),
       .b              (bta),
       .y              (pc_pre)
     );

mux2 #(32) pc_jmp_mux (
       .sel            (jump),
       .a              (pc_pre),
       .b              (jta),
       .y              (pc_next)
     );

mux2 #(32) jr_mux (
       .sel            (jr_sel),
       .a              (pc_next),
       .b              (rd1_out),
       .y              (jr_pc_next)
     );

/* --- RF Logic --- */
mux2 #(5) instr_wa_mux (
       .sel            (wr_ra_instr),
       .a              (instr[15:11]),
       .b              (instr[20:16]),
       .y              (instr_wa)
     );

mux2 #(5) jal_wa_mux (
       .sel            (wr_ra_jal),
       .a              (5'd0),
       .b              (5'd31),
       .y              (jal_wa)
     );

mux2 #(5) rf_wa_mux (
       .sel            (jump),
       .a              (instr_wa),
       .b              (jal_wa),
       .y              (rf_wa)
     );

regfile rf (
          .clk            (clk),
          .we             (we_reg),
          .ra1            (instr[25:21]),
          .ra2            (instr[20:16]),
          .ra3            (ra3),
          .wa             (rf_wa),
          .wd             (wd_rf),
          .rd1            (rd1_out),
          .rd2            (rd2_out),
          .rd3            (rd3)
        );

ext_unit ext_imm (
           .ext_sign0_zero1  (signExt0_zeroExt1),
           .a                (instr[15:0]),
           .y                (sext_imm)
         );

// --- ALU Logic --- //
mux2 #(32) alu_pb_mux (
       .sel            (alu_src_imm),
       .a              (rd2_out),
       .b              (sext_imm),
       .y              (alu_pb)
     );


alu alu (
      .op                (alu_ctrl),
      .a                 (rd1_out),
      .b                 (alu_pb),
      .shamt             (instr[10:6]),
      .slt_op            (slt_op),
      .arith_op          (arith_op),
      .zero              (zero),
      .overflow          (arith_overflow),
      .y                 (alu_out)
    );

// --- MULTIPLIER/DIVIDER R-TYPE Logic --- //
mul_div_unit mul_div(
               .inA                    (rd1_out),
               .inB                    (rd2_out),
               .mul0_div1_sel          (mul0_div1_sel),
               .outH                   (muldiv_high),
               .outL                   (muldiv_low)
             );

dreg high_reg (
       .clk            (clk),
       .rst            (rst),
       .d              (muldiv_high),
       .q              (muldiv_high_reg)
     );

dreg low_reg (
       .clk            (clk),
       .rst            (rst),
       .d              (muldiv_low),
       .q              (muldiv_low_reg)
     );

mux2 #(32) hilo_data_mux (
       .sel            (hi0_lo1_sel),
       .a              (muldiv_high_reg),
       .b              (muldiv_low_reg),
       .y              (hilo_mux_out)
     );

// --- MEM Logic --- //
mux2 #(32) wd_jal_mux (
       .sel            (jal_wd_sel),
       .a              (wd_hilo),
       .b              (pc_plus4),
       .y              (wd_rf)
     );

mux2 #(32) wd_hilo_mux (
       .sel            (hilo_mov_op),
       .a              (wd_alu_dm),
       .b              (hilo_mux_out),
       .y              (wd_hilo)
     );

mux2 #(32) alu_dm_data_mux (
       .sel            (dm_load_op),
       .a              (alu_out),
       .b              (rd_dm),
       .y              (wd_alu_dm)
     );
endmodule
