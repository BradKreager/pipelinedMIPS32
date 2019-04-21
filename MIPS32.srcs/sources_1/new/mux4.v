`timescale 1ns / 1ps

module mux4 #(parameter WIDTH = 8) (
        input  wire [1:0]       sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        input  wire [WIDTH-1:0] c, 
        input  wire [WIDTH-1:0] d, 
        output wire [WIDTH-1:0] y
    );

	always @(*) begin
		case(sel)
			2'b00: y = a;
			2'b01: y = b;
			2'b10: y = c;
			2'b11: y = d;
			default: y = {WIDTH{'bx}};
		endcase;
	end
endmodule
