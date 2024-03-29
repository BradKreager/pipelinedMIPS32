`timescale 1ns / 1ps

module tb_mips_top();

reg         clk = 0;
reg         rst = 0;
reg  [4:0]  ra3 = 0;
wire        we_dmM;
wire [31:0] pc_current;
wire [31:0] alu_out;
wire [31:0] wd_dm;
wire [31:0] rd3;
wire [31:0] rd1;
wire [2:0] a_ctrl;
wire [31:0] alu_pb;

wire [31:0] wd_rfW;
wire  branchE;
wire  jumpE;
wire  alu_src_immE;
wire  we_regE;
wire  we_regM;
wire  we_regW;
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
wire  jal_wd_selE;
wire  jal_wd_selM;
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
wire [4:0] rsE;
wire [4:0] rtE;
wire [4:0] rdE;
wire [4:0] shamtE;
wire [4:0] rf_waE;
wire [4:0] rf_waM;
wire [4:0] rf_waW;
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
reg  branch = 0;
reg  jump = 0;
reg  we_reg = 0;
reg  alu_src_imm = 0;
reg  hilo_mov_op = 0;
reg  hi0_lo1_sel = 0;
reg  mul0_div1_sel = 0;
reg  dm_load_op = 0;
reg  muldiv_op = 0;
reg  wr_ra_jal = 0;
reg  jal_wd_sel = 0;
reg  jr_sel = 0;
reg  wr_ra_instr = 0;
reg  slt_op = 0;
reg  arith_op = 0;
reg [2:0] alu_ctrl = 0;
wire [31:0] instr;
wire [31:0] rd_dm;
reg  signExt0_zeroExt1 = 0;
wire [31:0] instrD;
wire  arith_overflow;

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

wire muldiv_enE;
wire     muldiv_enE_qual;
wire hilo_read_done;

mips_top DUT (
           .muldiv_enE                  (muldiv_enE),
           .muldiv_enE_qual             (muldiv_enE_qual),
           .hilo_read_done              (hilo_read_done),
           .clk            (clk),
           .rst            (rst),
           .we_dmM          (we_dmM),
           .ra3            (ra3),
           .pc_current     (pc_current),
           .instr          (instr),
           .alu_out        (alu_out),
           .wd_dm          (wd_dm),
           .rd_dm          (rd_dm),
           .rd3            (rd3),
           .rd1(rd1),
           .a_ctrl (a_ctrl),
           .alu_pb (alu_pb),
           .wd_rfW                      (wd_rfW),
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
           .hilo_mux_outM               (hilo_mux_outM),
           .hilo_mux_outE               (hilo_mux_outE),
           .pc_plus8M                   (pc_plus8M),
           .pc_plus8W                   (pc_plus8W),
           .rd_dmW                      (rd_dmW),
           .hilo_mux_outW               (hilo_mux_outW),
           .instrD                 (instrD),
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
           .rRA          (rRA)
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
    tick;
    rst = 1'b0;
  end
endtask
integer i = 0;
initial
  begin
    reset;
    #5;
    ra3 = 5'd29;
    while(pc_current != 32'h40)
      tick;
    ra3 = 5'd16;
    tick;
    tick;


    $finish;
  end

endmodule
