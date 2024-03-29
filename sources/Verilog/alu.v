`timescale 1ns / 1ps

module alu (
         input  wire [2:0]  op,
         input  wire [31:0] a,
         input  wire [31:0] b,
         input  wire [4:0]  shamt,
         input  wire		   slt_op,
         input  wire        arith_op,
         output wire        zero,
         output reg		   overflow,
         output reg  [31:0] y
       );

wire shift_left,
     shift_var,
     shift_arith,
     signA,
     signB,
     aNEG_bPOS,
     aPOS_bNEG;

reg carry;

wire signR;

assign shift_arith = op[0];
assign shift_left  = op[1];
assign shift_var   = op[2];
assign aNEG_bPOS   = ~signA & signB;
assign aPOS_bNEG   = signA & ~signB;
assign signR       = y[31];

wire [4:0] shift_amt = (shift_var) ? b[4:0] : shamt;

assign signA = a[31];
assign signB = b[31];
assign zero = (y == 0) ? 1'b1 : 1'b0;


always @ (*)
  begin
    if(arith_op)
      begin
        if(op[2]) // BITWISE OPS
          begin
            carry = 1'b0;
            case (op[1:0])
              2'b00:
                y = a & b;
              2'b01:
                y = a | b;
              2'b11:
                y = ~(a | b);
              2'b10:
                y = a ^ b;
              default:
                y = 32'hxxxxxxxx;
            endcase
          end
        else // Not BITWISE
          begin
            case (op[1]) // ADD or SUB
              1'b0:
                {carry, y} = {1'b0, a} + {1'b0, b};
              1'b1:
                begin // SLT/SUB

                  {carry, y} = {1'b0, a} - {1'b0, b};

                  if(slt_op & ~op[0]) // signed SLT
                    begin


                      if((signA & signB) | (~signA & ~signB))
                        begin
                          y = {{31{1'b0}},signR};
                        end
                      else if(signA & ~signB) //a == neg, b == pos
                        begin
                          y = 32'd1;
                        end
                      else if(~signA & signB) // a == pos, b == neg
                        begin
                          y = 32'd0;
                        end
                    end

                  else if(slt_op & op[0]) // unsigned
                    begin
                      if(carry)
                        begin
                          y = 32'd0;
                        end
                      else if(~carry) // overflow
                        begin
                          y = 32'd1;
                        end
                    end
                end
              default:
                y = 32'hxxxxxxxx;
            endcase
          end
      end
    else // NOT arith_op -> shift ops
      begin
        case (op[1:0])
          2'b00:
            y = a << shift_amt;
          2'b01:
            y = a >> shift_amt;
          2'b11:
            y = a >>> shift_amt;
          default:
            y = 32'hxxxxxxxx;
        endcase
      end
  end

always@(*)
// always@(carry, y, op)
  begin
    if(~op[0] & ~op[2])
      begin
        case (op[2:1])
          2'b00:
            begin

              overflow = 0;
            end
          2'b10:
            begin
              overflow = 0;
            end
          default:
            overflow = 1'bx;
        endcase
      end
    else
      overflow = 1'b0;
  end


endmodule
