`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 11:55:03 AM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu(

);

reg [2:0] op = 0;
reg [31:0] a = 0;
reg [31:0] b = 0;
reg [4:0] shamt = 0;
reg  slt_op = 0;
reg  arith_op = 0;
wire  zero;
wire  overflow;
wire [31:0] y;

parameter
ADD = 3'b000,
	ADDU = 3'b001,
	SUB_SLT = 3'b010,
	SUBU_SLTU = 3'b011;

alu DUT (
	.op                (op),
	.a                 (a),
	.b                 (b),
	.shamt             (shamt),
	.slt_op            (slt_op),
	.arith_op          (arith_op),
	.zero              (zero),
	.overflow          (overflow),
	.y                 (y)
);

integer i, n;
initial
begin
	arith_op = 1'b1;
	slt_op = 1'b1;
	op = SUB_SLT;
	#5;
	for(i = 0; i < 128; i = i + 1)
	begin
		a = i;
		for(n = 0; n < 128; n = n + 1)
		begin
			b = n;
			#5;
		end
	end

	$finish;
end
endmodule
