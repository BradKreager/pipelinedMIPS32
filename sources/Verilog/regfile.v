module regfile (
	`ifdef SIM
		output wire [31:0] rAT,
		output wire [31:0] rV0,
		output wire [31:0] rV1,
		output wire [31:0] rA0,
		output wire [31:0] rA1,
		output wire [31:0] rA2,

		output wire [31:0] rT0,
		output wire [31:0] rT1,
		output wire [31:0] rT2,
		output wire [31:0] rT3,
		output wire [31:0] rT4,
		output wire [31:0] rT5,
		output wire [31:0] rT6,
		output wire [31:0] rT7,

		output wire [31:0] rS0,
		output wire [31:0] rS1,
		output wire [31:0] rS2,
		output wire [31:0] rS3,
		output wire [31:0] rS4,
		output wire [31:0] rS5,
		output wire [31:0] rS6,
		output wire [31:0] rS7,

		output wire [31:0] rT8,
		output wire [31:0] rT9,

		output wire [31:0] rK0,
		output wire [31:0] rK1,

		output wire [31:0] rGP,
		output wire [31:0] rSP,
		output wire [31:0] rFP,
		output wire [31:0] rRA,
	`endif
	input  wire        clk,
	input  wire        we,
	input  wire [4:0]  ra1,
	input  wire [4:0]  ra2,
	input  wire [4:0]  ra3,
	input  wire [4:0]  wa,
	input  wire [31:0] wd,
	output wire [31:0] rd1,
	output wire [31:0] rd2,
	output wire [31:0] rd3
);

	reg [31:0] rf [0:31];
	reg [4:0]  
	raddr1,
	raddr2,
	raddr3;

	integer n;

	initial
	begin
		for (n = 0; n < 32; n = n + 1)
			rf[n] = 32'h0;
		rf[29] = 32'h100; // Initialze $sp
	end

	always @ (negedge clk)
	begin
		raddr1 <= ra1;
		raddr2 <= ra2;
		raddr3 <= ra3;
	end

	always @ (posedge clk)
	begin
		if (we)
			rf[wa] <= wd;
	end

	assign rd1 = (raddr1 == 0) ? 0 : rf[raddr1];
	assign rd2 = (raddr2 == 0) ? 0 : rf[raddr2];
	assign rd3 = (raddr3 == 0) ? 0 : rf[raddr3];

	`ifdef SIM

		assign rAT = rf[1];
		assign rV0 = rf[2];
		assign rV1 = rf[3];
		assign rA0 = rf[4];
		assign rA1 = rf[5];
		assign rA2 = rf[6];
		assign rA3 = rf[7];

		assign rT0 = rf[8];
		assign rT1 = rf[9];
		assign rT2 = rf[10];
		assign rT3 = rf[11];
		assign rT4 = rf[12];
		assign rT5 = rf[13];
		assign rT6 = rf[14];
		assign rT7 = rf[15];

		assign rS0 = rf[16];
		assign rS1 = rf[17];
		assign rS2 = rf[18];
		assign rS3 = rf[19];
		assign rS4 = rf[20];
		assign rS5 = rf[21];
		assign rS6 = rf[22];
		assign rS7 = rf[23];

		assign rT8 = rf[24];
		assign rT9 = rf[25];

		assign rK0 = rf[26];
		assign rK1 = rf[27];

		assign rGP = rf[28];
		assign rSP = rf[29];
		assign rFP = rf[30];
		assign rRA = rf[31];
	`endif
endmodule
