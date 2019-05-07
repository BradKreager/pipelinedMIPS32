`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 09:05:21 PM
// Design Name: 
// Module Name: tb_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_system();
    reg clk = 0;
    reg rst;
    reg [31:0]gpI1;
    wire [31:0]gpI2;
    wire we_dmM;
    wire [31:0]wd_dm;
    
    wire [31:0]gpO2;
    wire [31:0]gpO1;
    wire [31:0]pc_current;

    wire muldiv_enE;
    wire muldiv_enE_qual;
    wire hilo_read_done;
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
    wire branchE;
    wire jumpE;
    wire alu_src_immE;
    wire we_regE;
    wire we_regM;
    wire we_regW;
    wire hilo_mov_opE;
    wire hilo_mov_opM;
    wire hilo_mov_opW;
    wire hi0_lo1_selE;
    wire mul0_div1_selE;
    wire mul0_div1_selM;
    wire dm_load_opE;
    wire wr_ra_jalE;
    wire jr_selE;
    wire wr_ra_instrE;
    wire slt_opE;
    wire arith_opE;
    wire [2:0]alu_ctrlE;
    wire signExt0_zeroExt1E;
    wire dm_load_opM;
    wire dm_load_opW;
    wire jal_wd_selE;
    wire jal_wd_selM;
    wire jal_wd_selW;
    wire mul0_div1_selW;
     
    // datapath
    wire [31:0] pc_plus4D;
    wire [31:0] pc_plus4E;
    wire zero;
    wire equalsD;
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
    wire [31:0] alu_pb;
    wire [2:0] a_ctrl;
    wire [31:0] rd1;
    wire [31:0] instrD;
    wire arith_overflow;

    system DUT(
        .muldiv_enE                  (muldiv_enE),
        .muldiv_enE_qual             (muldiv_enE_qual),
        .hilo_read_done              (hilo_read_done),
        .rd1 (rd1),
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
        .clk(clk),
        .rst(rst),
        .gpI1(gpI1),
        .gpI2(gpI2),
        .gpO1(gpO1),
        .gpO2(gpO2),
        .pc_current(pc_current),
        .we_dmM(we_dmM),
        .wd_dm_sim(wd_dm)
    );
    
    assign gpI2 = gpO1;
    
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
    initial begin
        gpI1 = 4;
        reset;
		#5;
		tick;
        while(pc_current != 32'h5c) tick;
        $finish;
    end
endmodule