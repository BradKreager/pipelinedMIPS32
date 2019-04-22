`timescale 1ns / 1ps

module mul_div_unit(
         input [31:0] inA,
         input [31:0] inB,
         input mul0_div1_sel,
         input en,
         output [31:0] outH,
         output [31:0] outL
       );

wire [31:0] mul_high,
     mul_low,
     outQ,
     outR;

combinational_multiplier MUL (
                           .mul_pa			(inA),
                           .mul_pb			(inB),
                           .en            (en),
                           .mul_high		(mul_high),
                           .mul_low		(mul_low)
                         );

divider_circuit DIV (
                  .inA           (inA),
                  .inB           (inB),
                  .en            (en),
                  .outQ          (outQ),
                  .outR          (outR)
                );

mux2 #(32) muldiv_high_mux (
       .sel            (mul0_div1_sel),
       .a              (mul_high),
       .b              (outQ),
       .y              (outH)
     );

mux2 #(32) muldiv_low_mux (
       .sel            (mul0_div1_sel),
       .a              (mul_low),
       .b              (outR),
       .y              (outL)
     );

endmodule
