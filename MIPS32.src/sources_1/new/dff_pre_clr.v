`timescale 1ns / 1ps


module dff_pre_clr #(parameter WIDTH = 32) (
         input [31:0] D,
         input PR,
         input CLR,
         input clk,
         output reg [31:0] Q
       );


always @(posedge clk)
  begin
    if(PR & CLR)
      Q <= D;
  end

always @*
  begin
    case({PR,CLR})
      2'b01:
        Q <= {WIDTH-1{1'b1}};
      2'b10:
        Q <= {WIDTH-1{1'b0}};
      default:
        Q <= {WIDTH-1{1'bx}};
    endcase
  end
endmodule
