`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 03:05:34 AM
// Design Name: 
// Module Name: factorial_dp
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


module factorial_dp(
        //Data inputs
        input [7:0]n,
        //Control inputs
        input clk,
        input rst,
        input prod_mux_sel,
        input prod_reg_ld,
        input cnt_ld,
        input cnt_en,
        input out_mux_sel,
        
        //Feedback to FSM
        output a_gt_b,
        output err,
        output [31:0]factorial_out
    );
    
    
    wire [7:0] dwn_cnt_out_w;
    wire [7:0] input_value;
    wire [31:0] mult_out_w;
    wire [31:0] prod_mux_out_w;
    wire [31:0] prod_reg_out_w;
    
	assign input_value = (n == 8'b0) ? 8'd1 : n;

    assign err = (n > 8'd12 ? 1'b1 : 1'b0);

    updown dwn_cnt(
        .d(input_value),
        .ud(1'b0),
        .ce(cnt_en),
        .ld(cnt_ld),
        .rst(rst),
        .clk(clk),
        .q(dwn_cnt_out_w)
    );
    
    mux2 #(32)prod_mux(
        .a(32'd1),
        .b(mult_out_w),
        .sel(prod_mux_sel),
        .y(prod_mux_out_w)
    );
    
    dreg_sync_rst_en prod_reg(
        .clk(clk),
        .rst(rst),
        .en(prod_reg_ld),
        .d(prod_mux_out_w),
        .q(prod_reg_out_w)
    );
    
    comb_multiplier32 mult(
        .x({24'b0, dwn_cnt_out_w}),
        .y(prod_reg_out_w),
        .z(mult_out_w)
    );
    
    comparator cmp(
        .a({24'b0, dwn_cnt_out_w}),
        .b(32'd1),
        .gt(a_gt_b)
    );
    
    mux2 #(32)out_mux(
        .a(32'd0),
        .b(prod_reg_out_w),
        .sel(out_mux_sel),
        .y(factorial_out)
    );
endmodule
