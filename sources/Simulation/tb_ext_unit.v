`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 03:52:25 PM
// Design Name: 
// Module Name: tb_ext_unit
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


module tb_ext_unit(

    );
 
reg  ext_zero0_sign1 = 0;
reg [15:0] a = 0;
wire [31:0] y;
 
ext_unit DUT (
.ext_zero0_sign1          (ext_zero0_sign1),
.a                        (a),
.y                        (y)
);

initial
begin
	ext_zero0_sign1 = 1'b1;
	a = 16'hFFFF;
	#10;
	ext_zero0_sign1 = 1'b0;
	a = 16'hFFFF;
	#10;
end

endmodule
