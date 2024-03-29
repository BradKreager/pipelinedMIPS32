`timescale 1ns / 1ps

module dreg_en #(parameter WIDTH = 32)(
        input  wire             clk,
        input  wire             rst,
        input  wire             clr,
        input  wire             en,
        input  wire [WIDTH-1:0] d,
        output reg  [WIDTH-1:0] q
    );

    always @ (posedge clk, posedge rst) begin
        if      (rst) q <= 0;
        else if	(~en) 
		begin
			if(clr) q <= 0;	
		    else q <= d;
		end
        else q <= q;
    end
endmodule
