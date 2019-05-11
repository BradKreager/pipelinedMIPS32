`timescale 1ns / 1ps

module tb_system();

reg  clk = 0;
reg  rst = 0;
reg [31:0] gpI1 = 0;
wire [31:0] gpI2;
wire [31:0] gpO2;
wire [31:0] gpO1;
wire [31:0] pc_current;
 
assign gpI2 = gpO1;

system DUT (
.clk                 (clk),
.rst                 (rst),
.gpI1                (gpI1),
.gpI2                (gpI2),
.gpO2                (gpO2),
.gpO1                (gpO1),
.pc_current          (pc_current)
);


	task tick;
		begin
			clk = 1'b0;
			#5;
			clk = 1'b1;
			#5;
		end
	endtask




	task reset;
		begin
			rst = 1'b0;
			#5;
			rst = 1'b1;
			#5;
			rst = 1'b0;
			#5;
			//rst <= #5 1'b0;
			//rst <= #5 1'b1;
			//rst <= #5 1'b0;
		end
	endtask


	integer errors = 0;
	integer exp_factorial = 0;
	integer test;


	function automatic integer fact;
		// Input Params
		input integer n;
		// Local Vars
		integer result, count;
		begin //routine
			result = 1;
			if(n <= 1)
			begin
				fact = 1;
			end
			else
			begin
				for(count = n; count > 0; count = count - 1)
				begin
					result = result * count;
				end
				fact = result;
			end //end else
		end //end routine
	endfunction
	




	integer i = 2;

	wire fact_done; 
	assign fact_done = (pc_current == 32'h3c) ? 1'b1 : 1'b0;

	initial
	begin
		$monitor("n = %d; Expected: %d; Result: %d; Time: %t", i, exp_factorial, gpO2, $time);
		gpI1 = i;
		test = i;
		#1;
		reset;
		forever #5 clk = ~clk;
	end

	always @(posedge fact_done) ->done;

	event done;

	always @(done)
	begin
		exp_factorial = fact(i);
		#1;
		i = i + 1;
		gpI1 = i;
		test = i;
		if(gpO2 != exp_factorial) errors = errors + 1;
	end

	always @(done)
	begin
		if(i == 13) $finish;
		reset;
	end

endmodule
