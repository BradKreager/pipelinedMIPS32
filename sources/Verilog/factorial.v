`timescale 1ns / 1ps

module fact(
    //Data input
    input [7:0]n,
    //Control inputs
    input go,
    input clk,
    input rst,
    //Data output
    output [31:0] factorial_out,
    //Status outputs
    output done,
    output err
    );
    
    wire prod_mux_sel_w;
    wire prod_reg_ld_w;
    wire cnt_ld_w;
    wire cnt_en_w;
    wire out_mux_sel_w;     
    wire a_gt_b_w;
    
    factorial_dp dp(
        .n(n),
        .clk(clk),
        .rst(rst),
        .prod_mux_sel(prod_mux_sel_w),
        .prod_reg_ld(prod_reg_ld_w),
        .cnt_ld(cnt_ld_w),
        .cnt_en(cnt_en_w),
        .out_mux_sel(out_mux_sel_w),
        .a_gt_b(a_gt_b_w),
        .err(err),
        .factorial_out(factorial_out)
    );
    factorial_fsm fsm(
        .go(go),
        .clk(clk),
        .rst(rst),
        .prod_mux_sel(prod_mux_sel_w),
        .prod_reg_ld(prod_reg_ld_w),
        .cnt_ld(cnt_ld_w),
        .cnt_en(cnt_en_w),
        .out_mux_sel(out_mux_sel_w),
        .a_gt_b(a_gt_b_w),
        .err(err),
        .done(done)
    );
    
endmodule
