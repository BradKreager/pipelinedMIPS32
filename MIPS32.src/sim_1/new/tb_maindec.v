`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 10:52:54 AM
// Design Name: 
// Module Name: tb_maindec
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


module tb_maindec(

    );
 
reg [5:0] opcode = 0;
wire  branch;
wire  jump;
wire  we_reg;
wire  alu_src_imm;
wire  we_dm;
wire [2:0] alu_op;
wire  wr_ra_jal;
wire  wr_ra_instr;
wire  jal_wd_sel;
wire  dm_load_op;
wire  r_type;
 
maindec DUT (
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

integer i;

initial begin
	for(i = 0; i < 64; i = i + 1)
	begin
		#5
		opcode = i; 
	end
$finish;
end


endmodule
