`timescale 1ns / 1ps

module tb_mips_top;

    reg         clk = 0;
    reg         rst = 0;
	reg  [4:0]  ra3 = 0;
    wire        we_dm;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] rd3;
	wire [31:0] rd1;
	wire [2:0] a_ctrl;
	wire [31:0] alu_pb;
    
    mips_top DUT (
            .clk            (clk),
            .rst            (rst),
            .we_dm          (we_dm),
            .ra3            (ra3),
            .pc_current     (pc_current),
            .instr          (instr),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd_dm          (rd_dm),
            .rd3            (rd3),
			.rd1(rd1),
			.a_ctrl (a_ctrl),
			.alu_pb (alu_pb)
        );
    
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    integer i = 0;
    initial begin
        reset;
		#5;
		ra3 = 5'd29;
        while(pc_current != 32'h58) tick;
		ra3 = 5'd16;
        $finish;
    end

endmodule
