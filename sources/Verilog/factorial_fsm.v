`timescale 1ns / 1ps


module factorial_fsm(
    //Control inputs
    input clk,
    input rst,
    input go,
    //Inputs from the datapath
    input a_gt_b,
    input err,
    //Outputs to the datapath
    output reg prod_mux_sel,
    output reg prod_reg_ld,
    output reg cnt_ld, 
    output reg cnt_en,
    output reg out_mux_sel,
    output reg done
    );
    
	localparam
	INIT = 2'd0,
	LOAD = 2'd1,
	WAIT = 2'd2;

    reg[1:0] state = 2'd0;
    
    always @(negedge clk, posedge rst) begin
        if(rst) begin
            state = 0;
            done = 0;
            prod_mux_sel = 0;
            prod_reg_ld = 0;
            cnt_ld = 0;
            cnt_en = 0;
            out_mux_sel = 0;
        end
        else begin
            case(state)
            //State 0: Start state
            INIT: begin
                //Initialize all the signals
                done = 1;
                prod_mux_sel = 0;
                prod_reg_ld = 0;
                cnt_ld = 0;
                cnt_en = 0;
                //Keep the previous product on the bus
                out_mux_sel = 1;                
                //Check the go signal
                if(go) begin
                    //Check the error signal
                    if(!err) begin
                        //Load a 1 into the product register
                        prod_mux_sel = 0;
                        prod_reg_ld = 1;
                        //Load the input into the down counter
                        cnt_ld = 1;
                        cnt_en = 1;
                        //Take the result off the bus
                        out_mux_sel = 0;
                        //Remove the done signal
                        done = 0;             
                        //Increase the state
                        state = LOAD;
                    end
                    //Do nothing on error
                end
                else begin
                    //Do nothing if go isn't asserted
                end
            end
            //State 1: Load state
            LOAD: begin
                //Stop loading to the down counter
                cnt_ld = 0;
                //Decrement the down counter
                cnt_en = 1;
                //Mux the multiplied output back to the product register
                prod_mux_sel = 1;
                //Load the product register with the product
                prod_reg_ld = 1;
                //Increase the state
                state = WAIT;
            end
            
            //State 2: Wait state
            WAIT: begin
                //Don't decrement the down counter again
                cnt_en = 0;
                //Stop loading the product reguster
                prod_reg_ld = 0;
                //If down count > 1, loop again
                if(a_gt_b) begin
                    state = LOAD;
                end
                //Otherwise, mux out the result and activate the done signal
                else begin
                    out_mux_sel = 1;
                    done = 1;
                    state = INIT;
                end
            end
        endcase
        end
    end
        
endmodule
