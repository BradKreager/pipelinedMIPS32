`timescale 1ns / 1ps

module updown#(parameter WIDTH=8)(
	//Control inputs
	input rst,
	input ld,
	input clk,
	input ce,
	//Data inputs
	input [WIDTH-1:0]d,
	//Data control signals
	input ud,
	//Outputs
	output reg [WIDTH-1:0]q
);
	always @(posedge clk, posedge rst) begin
		//Async reset
		if(rst)begin
			q <= 0;
			//$display("COUNT: Reset");
		end
		//Synchronous load
		else if(ld & ce) begin
			q <= d;
			//$display("COUNT: Loaded %d", q);
		end
		//Synchronous down count
		else if(!ud & ce) begin
			q <= q - 1;
			//$display("COUNT: --, %d", q);
		end
		//Synchronous up count
		else if(ud & ce) begin
			q <= q + 1;
			//$display("COUNT: ++, %d", q);
		end
		//Otherwise, hold state
		else begin
			q <= q;
		end
	end
	// else begin
	// else if(clk) begin
	//Synchronous load
	// if(ld & ce) begin
	// q <= d;
	//$display("COUNT: Loaded %d", q);
	// end
	//Synchronous down count
	// else if(!ud & ce) begin
	// q <= q - 1;
	//$display("COUNT: --, %d", q);
	// end
	//Synchronous up count
	// else if(ud & ce) begin
	// q <= q + 1;
	//$display("COUNT: ++, %d", q);
	// end
	//Otherwise, hold state
	// else begin
	// q <= q;
	// end
	// end
	// end
endmodule
