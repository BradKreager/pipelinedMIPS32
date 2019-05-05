`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 03:25:07 AM
// Design Name: 
// Module Name: tb_gpio
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


module tb_gpio();

    reg we_t;
    reg rst_t;
    reg clk_t;
    
    reg [1:0]a_t;
    
    reg [31:0]gpI1_t;
    reg [31:0]gpI2_t;
    
    reg [31:0]wd_t;
    
    wire [31:0]rd_t;
    wire [31:0]gpO1_t;
    wire [31:0]gpO2_t;
    
    gpio_top DUT(
        .we(we_t),
        .rst(rst_t),
        .clk(clk_t),
        .a(a_t),
        .gpI1(gpI1_t),
        .gpI2(gpI2_t),
        .wd(wd_t),
        .rd(rd_t),
        .gpO1(gpO1_t),
        .gpO2(gpO2_t)
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
        while(test_value < 32'hFFFEFFFF) begin
            $display("Testing GPIO input port 1...");
            gpI1_t = test_value;
            a_t = 2'b00;
            tick;
            if(rd_t == test_value) begin
                $display("SUCCESS: Expected 0x%h, got 0x%h", test_value, rd_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got 0x%h", test_value, rd_t);
                errors = errors + 1;
            end
            
            $display("Testing GPIO input port 2...");
            gpI2_t = test_value;
            a_t = 2'b01;
            tick;
            if(rd_t == test_value) begin
                $display("SUCCESS: Expected 0x%h, got 0x%h", test_value, rd_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got 0x%h", test_value, rd_t);
                errors = errors + 1;
            end
            
            $display("Testing GPIO output port 1...");
            wd_t = test_value;
            we_t = 1'b1;
            a_t = 2'b10;
            tick;
            if((rd_t == test_value) && (gpO1_t == test_value)) begin
                $display("SUCCESS: Expected 0x%h, got rd_t=0x%h and gpO1_t=0x%h", test_value, rd_t, gpO1_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got rd_t=0x%h and gpO1_t=0x%h", test_value, rd_t, gpO1_t);
                errors = errors + 1;
            end
            $display("Testing WE pin on GPIO output port 1...");
            wd_t = test_value + 1;
            we_t = 1'b0;
            a_t = 2'b10;
            tick;
            if((rd_t == test_value) && (gpO1_t == test_value)) begin
                $display("SUCCESS: Expected 0x%h, got rd_t=0x%h and gpO1_t=0x%h", test_value, rd_t, gpO1_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got rd_t=0x%h and gpO1_t=0x%h", test_value, rd_t, gpO1_t);
                errors = errors + 1;
            end
            
            $display("Testing GPIO output port 2...");
            wd_t = test_value + 1;
            we_t = 1'b1;
            a_t = 2'b11;
            tick;
            if((rd_t == test_value + 1) && (gpO2_t == test_value + 1)) begin
                $display("SUCCESS: Expected 0x%h, got rd_t=0x%h and gpO2_t=0x%h", test_value + 1, rd_t, gpO2_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got rd_t=0x%h and gpO2_t=0x%h", test_value + 1, rd_t, gpO2_t);
                errors = errors + 1;
            end
            $display("Testing WE pin on GPIO output port 2...");
            wd_t = test_value - 1;
            we_t = 1'b0;
            a_t = 2'b11;
            tick;
            if((rd_t == test_value + 1) && (gpO2_t == test_value + 1)) begin
                $display("SUCCESS: Expected 0x%h, got rd_t=0x%h and gpO2_t=0x%h", test_value + 1, rd_t, gpO2_t); 
            end
            else begin
                $display("ERROR: Expected 0x%h, got rd_t=0x%h and gpO2_t=0x%h", test_value + 1, rd_t, gpO2_t);
                errors = errors + 1;
            end
            
            $display("Making sure WE works correctly and register contents were properly preserved...");
            if((gpO1_t == test_value) && (gpO2_t == test_value + 1)) begin
                $display("SUCCESS: Contents of gp01 were preserved");
            end
            else begin
                $display("ERROR: Contents of gp01 corrupted across writes");
                errors = errors + 1;
            end
            wd_t = test_value + 2;
            we_t = 1'b1;
            a_t = 2'b10;
            tick;
            if((gpO1_t == test_value + 2) && (gpO2_t == test_value + 1)) begin
                $display("SUCCESS: Contents of gp02 were preserved");
            end
            else begin
                $display("ERROR: Contents of gp02 corrupted across writes");
                errors = errors + 1;
            end
            test_value = test_value + 32'h000FFFF; //This testbench takes hours to run on smaller values
        end
        $display("Testbench complete. Errors: %d", errors);
    end
endmodule
