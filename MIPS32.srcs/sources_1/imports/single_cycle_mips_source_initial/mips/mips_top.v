module mips_top (
`ifdef SIM
         wire muldiv_enE,
         wire     muldiv_enE_qual,
         wire hilo_read_done,
		 wire [31:0] instrD,
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

         output wire [31:0] rd1,
         output wire [2:0] a_ctrl,
         output wire [31:0] alu_pb,

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
`endif
         input  wire        clk,
         input  wire        rst,
         input  wire [4:0]  ra3,
         output wire        we_dm,
         output wire [31:0] pc_current,
         output wire [31:0] instr,
         output wire [31:0] alu_out,
         output wire [31:0] wd_dm,
         output wire [31:0] rd_dm,
         output wire [31:0] rd3
       );

// wire [31:0] DONT_USE;

mips mips (
`ifdef SIM
       .muldiv_enE                  (muldiv_enE),
       .muldiv_enE_qual             (muldiv_enE_qual),
       .hilo_read_done              (hilo_read_done),
       .rd1(rd1),
       .a_ctrl (a_ctrl),
       .alu_pb (alu_pb),
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
	   .instrD                 (instrD),

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
       .rst            (rst),
       .ra3            (ra3),
       .instr          (instr),
       .rd_dm          (rd_dm),
       .we_dm          (we_dm),
       .pc_current     (pc_current),
       .alu_out        (alu_out),
       .wd_dm          (wd_dm),
       .rd3            (rd3)
     );

imem imem (
       .a              (pc_current[7:2]),
       .y              (instr)
     );

dmem dmem (
       .clk            (clk),
       .we             (we_dm),
       .a              (alu_out[7:2]),
       .d              (wd_dm),
       .q              (rd_dm)
     );

endmodule
