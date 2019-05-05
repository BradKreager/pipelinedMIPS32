`timescale 1ns / 1ps

module mux4 #(parameter WIDTH = 8) (
        input  wire [1:0]       sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        input  wire [WIDTH-1:0] c, 
        input  wire [WIDTH-1:0] d, 
        output wire [WIDTH-1:0] y
    );

    assign y = (sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a));

endmodule
