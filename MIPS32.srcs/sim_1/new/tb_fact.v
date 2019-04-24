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
    
    integer errors = 0;
    integer test_value = 32'h0;
    
    initial begin
        reset;
        tick;
        
        $display("Performing simple factorial test...");
        //Select the input register for writing
        a_t = 2'b00;
        //Enable writes
        we_t = 1'b1;
        //Tell the module to perform the 3!
        wd_t = 4'd3;
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
        if(rd_t == 32'd6) begin
            $display("SUCCESS: Expected %d, got %d", 6, rd_t);
        end
        else begin
            $display("ERROR: Expected %d, got $d", 6, rd_t);
            errors = errors + 1;
        end
    end
endmodule
