`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:23:32 AM
// Design Name: 
// Module Name: tb_fact
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


module tb_fact();
    
    reg [1:0]a_t;
    reg we_t;
    reg [3:0]wd_t;
    reg rst_t;
    reg clk_t;
    
    wire [31:0]rd_t;
    
    fact_top DUT(
        .a(a_t),
        .we(we_t),
        .wd(wd_t),
        .rst(rst_t),
        .clk(clk_t),
        .rd(rd_t)
    );
    
    task tick;
      begin
        clk_t = 1'b0;
        #5;
        clk_t = 1'b1;
        #5;
      end
    endtask
    
    task reset;
      begin
        rst_t = 1'b0;
        #5;
        rst_t = 1'b1;
        #5;
        tick;
        rst_t = 1'b0;
      end
    endtask
    
    task full_cycle;
        begin
        end
    endtask
    
    integer errors = 0;
    
    integer exp_factorial = 32'd0;
    integer test_factorial = 4'd3;
    integer product = 1;
    integer i = 4'd1;
    
    task calc_factorial;
        begin
            product = 1;
            while(test_factorial > 1) begin
                product = product * test_factorial;
                test_factorial = test_factorial - 1;
            end
            exp_factorial = product;
        end
    endtask
    
    task test_full_cycle;
        begin
            $display("Performing factorial test with input %d...", test_factorial);
            //Select the input register for writing
            a_t = 2'b00;
            //Enable writes
            we_t = 1'b1;
            //Tell the module to perform the factorial with input of test_factorial
            wd_t = test_factorial;
            //Tick the module to write to the input register
            tick;
            
            //Write to the go bit to start the computation
            //Select the go register for writing
            a_t = 2'b01;
            //Enable writes
            we_t = 1'b1;
            //Write a 1 to the go register
            wd_t = 4'b0001;
            //Tick the module to write to the go register
            tick;
            
            //Select the status register for reading
            a_t = 2'b10;
            //Disable writes
            we_t = 1'b0;
            //Tick so the status register gets read (could use a delay, address decoder is combinational)
            tick;
            //Tick the module until the done flag gets set
            while(!rd_t[0]) begin
                $display("Ticking factorial module...");
                tick;
            end
            
            //When the module is done calculating, output the result and check it
            //Select the output register for reading
            a_t = 2'b11;
            //Disable writes
            we_t = 1'b0;
            //Tick so the data becomes available. (could use a simple delay here, address decoder is combinational)
            tick;
            //Check the output
            calc_factorial;
            if(rd_t == exp_factorial) begin
                $display("SUCCESS: Expected %d, got %d", exp_factorial, rd_t);
            end
            else begin
                $display("ERROR: Expected %d, got %d", exp_factorial, rd_t);
                errors = errors + 1;
            end
        end
    endtask
    
    initial begin
        reset;
        tick;
        test_factorial = 4'd3;
        test_full_cycle;
        $display("Testing data retention in factorial module...");
        tick;
        tick;
        tick;
        tick; 
        //Check the output
        if(rd_t == 32'd6) begin
            $display("SUCCESS: Expected %d, got %d", 6, rd_t);
        end
        else begin
            $display("ERROR: Expected %d, got %d", 6, rd_t);
            errors = errors + 1;
        end
        
        //Checking the error flag
        test_factorial = 4'd13;
        //Select the input register for writing
        a_t = 2'b00;
        //Enable writes
        we_t = 1'b1;
        //Tell the module to perform the factorial with input of test_factorial
        wd_t = test_factorial;
        //Tick the module to write to the input register
        tick;
        
        //Write to the go bit to start the computation
        //Select the go register for writing
        a_t = 2'b01;
        //Enable writes
        we_t = 1'b1;
        //Write a 1 to the go register
        wd_t = 4'b0001;
        //Tick the module to write to the go register
        tick;
        
        //Select the status register for reading
        a_t = 2'b10;
        //Disable writes
        we_t = 1'b0;
        //Tick so the status register gets read (could use a delay, address decoder is combinational)
        tick;
    
        if(rd_t[1]) begin
            $display("SUCCESS: Error flag caught");
        end
        else begin
            $display("FAILURE: Did not catch error flag");
            errors = errors + 1;
        end
        
        $display("Performing exhaustive test...");
        for (i = 1; i < 13; i = i + 1) begin
            test_factorial = i;
            test_full_cycle;
        end

        
    end
endmodule
