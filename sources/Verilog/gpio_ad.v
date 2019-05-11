`timescale 1ns / 1ps

module gpio_ad(
    input wire [1:0]a,
    input wire we,
    
    output wire we2,
    output wire we1,
    
    output wire [1:0] rdsel
    );
    
    assign rdsel = a;
    //Activate we1 when rdsel = 10 and we = 1
    assign we1 = (we & rdsel[1] & ~rdsel[0]);
    //Activate we2 when rdsel = 11 and we = 1
    assign we2 = (we & rdsel[1] &  rdsel[0]);

endmodule
