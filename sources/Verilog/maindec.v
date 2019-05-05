`timescale 1ns / 1ps

module maindec (
	input  wire [5:0] opcode,
	output wire       branch,
	output wire       jump,
	output wire       we_reg,
	output wire       alu_src_imm,
	output wire       we_dm,
	output wire [2:0] alu_op,
	output wire	      wr_ra_jal,
	output wire		  wr_ra_instr,
	output wire		  jal_wd_sel,
	output wire		  dm_load_op,
	output wire	      r_type
);

parameter
SLT = 3'b010,
ADD = 3'b001;


wire alu_src_rd2,
	store_op,
	store_conditional,
	dm_op,
	store_bit;

assign r_type = ~|opcode;

assign dm_op = (opcode[5] & ~opcode[4]) | &opcode[5:4];

assign store_bit = opcode[3];

assign store_op = dm_op & store_bit;

assign dm_load_op = dm_op & ~store_bit;

assign store_conditional = store_op & ~|opcode[2:0];

assign alu_src_imm = |(opcode[5:3]);

assign alu_src_rd2 = ~alu_src_imm;

assign branch = alu_src_rd2 & opcode[2];

assign alu_op = 
	branch ? ADD :
	dm_op  ? ADD :
	opcode[2:0];

assign we_reg = ~(branch | (store_op & ~store_conditional) );

assign jump = ~|(opcode[5:2]) & opcode[1];

assign wr_ra_jal = opcode[0];

assign wr_ra_instr = alu_src_imm;

assign jal_wd_sel = jump;

assign we_dm = store_op;



endmodule
