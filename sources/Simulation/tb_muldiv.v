`timescale 1ns / 1ps

module tb_muldiv(

       );

reg [31:0] inA = 0;
reg [31:0] inB = 0;
reg  mul0_div1_sel = 0;
wire [31:0] outH;
wire [31:0] outL;

mul_div_unit DUT (
               .inA                    (inA),
               .inB                    (inB),
               .mul0_div1_sel          (mul0_div1_sel),
               .outH                   (outH),
               .outL                   (outL)
             );

integer i, n;

initial
  begin


    $finish;
  end

endmodule
