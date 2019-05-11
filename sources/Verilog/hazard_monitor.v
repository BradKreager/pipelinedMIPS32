`timescale 1ns / 1ps


module hazard_monitor(
	output  wire        forwardAD,
	output  wire        forwardBD,
	output  reg [1:0]   forwardAE,
	output  reg [1:0]   forwardBE,

	output  wire        stallF,
	output  wire        stallD,
	output  wire        flushE,

	input wire [4:0]  rsD,
	input wire branch,
	input wire [4:0]  rtD,
	input wire [4:0]  rdD,
	input wire [4:0] rsE,
	input wire [4:0]  rtE,
	input wire		  we_regE,
	input wire		  we_regM,
	input wire		  we_regW,
	input wire [4:0] rf_waE,
	input wire [4:0] rf_waM,
	input wire [4:0] rf_waW,
	input wire		   dm_load_opM,
	input wire		   dm_load_opE
);


	assign branchstall = branch & we_regE & (rf_waE == rsD | rf_waE == rtD)
					  | branch & dm_load_opM & (rf_waM == rsD | rf_waM == rtD);

	assign lwstall = ((rsD == rtE) | (rtD == rtE)) & dm_load_opE;

	assign stallF = lwstall | branchstall;

	assign stallD = lwstall | branchstall;

	assign flushE = lwstall | branchstall;

	assign forwardAD = |rsD  & (rsD == rf_waM) & we_regM;
	assign forwardBD = |rtD   & (rtD == rf_waM) & we_regM;

	always @(*)
	begin
		if(|(rsE) & (rsE == rf_waM) & we_regM) forwardAE = 2'b10;
		else if(|(rsE) & (rsE == rf_waW) & we_regW) forwardAE = 2'b01;
		else forwardAE = 2'b00;

		if(|(rtE) & (rtE == rf_waM) & we_regM) forwardBE = 2'b10;
		else if(|(rtE) & (rtE == rf_waW) & we_regW) forwardBE = 2'b01;
		else forwardBE = 2'b00;
	end
endmodule
