`timescale 1ns / 1ps

module auxdec (
	input  wire [2:0] alu_op,
	input  wire [5:0] funct,
	input  wire		  r_type,
	output wire [2:0] alu_ctrl,
	output wire       slt_op,
	output wire	      arith_op,
	output wire       hilo_mov_op,
	output wire	      hi0_lo1_sel,
	output wire       mul0_div1_sel,
	output wire		  jr_sel,
	output wire       signExt0_zeroExt1,
	output wire	      muldiv_op
);

wire muldiv_op,
	jump_reg_op;


assign slt_op = 
	(r_type)    ? funct[3] :
	(alu_op[2])  ? 1'b0     :
	(~alu_op[1]) ? 1'b0     : 1'b1;


assign alu_ctrl = (r_type) ? funct[2:0] : alu_op;
assign arith_op = (r_type) ? funct[5]   : 1'b1;

assign signExt0_zeroExt1 = alu_ctrl[2];


assign hilo_mov_op = (~funct[5] & funct[4] & ~|funct[3:2]);
assign hi0_lo1_sel = hilo_mov_op & funct[1];


assign muldiv_op = ~funct[5] & (&funct[4:3] & ~funct[2]);
assign mul0_div1_sel = muldiv_op & funct[1];

assign jump_reg_op = ~|(funct[5:4]) & funct[3] & ~|(funct[2:1]);

assign jr_sel = jump_reg_op & r_type; 

endmodule
