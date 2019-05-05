`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 06:52:35 PM
// Design Name: 
// Module Name: gpio_ad
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
