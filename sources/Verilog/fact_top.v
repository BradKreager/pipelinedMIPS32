`timescale 1ns / 1ps

module fact_top(
        input wire [1:0]a,
        input wire we,
        input wire [3:0]wd,
        input rst,
        input clk,
        
        output [31:0]rd
    );
    
    wire go_pulse;
    wire go;
    wire go_pulse_comb;
    wire [3:0]n;
    wire done;
    wire err;
    wire [31:0]nf;
    wire res_done;
    wire res_err;
    wire [31:0]result;
    wire we1;
    wire we2;
    wire [1:0]rd_sel;
    
    assign go_pulse_comb = wd[0] & we2;
    
    //Address decoder
    fact_ad addr_dev(
        .a(a),
        .we(we),
        .we1(we1),
        .we2(we2),
        .rd_sel(rd_sel)
    );
    
    //The actual factorial accelerator
    fact fact_acc(
        .n({4'b0000, n}), //The factorial module I built takes an 8 bit input. Pad the other bits
        .go(go_pulse),
        .clk(clk),
        .rst(rst),
        .done(done),
        .err(err),
        .factorial_out(nf)
    );
    
    //The dreg stores the number to be factorialed
    dreg_en_pos#(4) input_dreg(
        .clk(clk),
        .rst(rst),
		.clr(1'b0),
        .en(we1),
        .d(wd),
        .q(n)
    );
    
    //This dreg stores the go bit
    dreg_en_pos #(1) go_bit_dreg(
        .clk(clk),
        .rst(rst),
		.clr(1'b0),
        .en(we2),
        .d(wd[0]),
        .q(go)
    );
    
    //This dreg takes the combinational go pulse and generates the real go pulse
    dreg_en_pos #(1) go_signal_dreg(
        .clk(clk),
        .rst(rst),
		.clr(1'b0),
        .en(1'b1),
        .d(go_pulse_comb),
        .q(go_pulse)
    );
    
    //This dreg stores the done flag from the factorial accelerator
    dreg_en_pos #(1) done_bit_dreg(
        .clk(clk),
        .rst(go_pulse_comb),
		.clr(1'b0),
        .en(1'b1),
        .d(done),
        .q(res_done)
    );
    
    //This dreg stores the err flag from the factorial accelerator
    dreg_en_pos #(1) err_bit_dreg(
        .clk(clk),
        .rst(go_pulse_comb),
		.clr(1'b0),
        .en(1'b1),
        .d(err),
        .q(res_err)
    );
    
    //This dreg stores the result of the factorial operation
    dreg_en_pos #(32) result_dreg(
        .clk(clk),
        .rst(rst),
		.clr(1'b0),
        .en(done),
        .d(nf),
        .q(result)
    );
    
    mux4#(32) mux_out(
        .sel(rd_sel),
        .a({28'b0, n}),
        .b({31'b0, go}),
        .c({30'b0, res_err, res_done}),
        .d(result),
        .y(rd)
    );
endmodule
