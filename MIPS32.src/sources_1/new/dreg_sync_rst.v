`timescale 1ns / 1ps

module dreg_sync_rst #(parameter WIDTH = 32) (
        input  wire             clk,
        input  wire             rst,
        input  wire [WIDTH-1:0] d,
        output reg  [WIDTH-1:0] q
    );

    always @ (posedge clk) 
	begin
        if (rst) q <= 0;
        else     q <= d;
    end

endmodule
