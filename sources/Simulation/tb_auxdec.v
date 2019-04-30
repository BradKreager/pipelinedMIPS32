`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 11:54:27 AM
// Design Name: 
// Module Name: tb_auxdec
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


module tb_auxdec(

    );
 
reg [2:0] alu_op = 0;
reg [5:0] funct = 0;
reg  r_type = 0;
wire [2:0] alu_ctrl;
wire  slt_op;
wire  arith_op;
wire  hilo_mov_op;
wire  hi0_lo1_sel;
wire  mul0_div1_sel;
wire  jr_sel;
 
auxdec DUT (
.alu_op                 (alu_op),
.funct                  (funct),
.r_type                 (r_type),
.alu_ctrl               (alu_ctrl),
.slt_op                 (slt_op),
.arith_op               (arith_op),
.hilo_mov_op            (hilo_mov_op),
.hi0_lo1_sel            (hi0_lo1_sel),
.mul0_div1_sel          (mul0_div1_sel),
.jr_sel                 (jr_sel)
);

integer i;

initial 
begin
	alu_op = 3'd000;
	funct = 6'h8;
	r_type = 1'b1;
	#5;



end

endmodule
