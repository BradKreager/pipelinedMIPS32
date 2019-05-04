module clk_gen (
         input  wire clk100MHz,
         input  wire rst,
         output reg  clk_4sec,
         output reg  clk_5KHz
       );

reg [31:0] count1, count2, count2next, count1next;

reg rst_pulse,
    rst_mem1,
    rst_mem2,
    rst_mem3;

always @(posedge clk100MHz)
  begin
    rst_mem1 <= rst;
    rst_mem2 <= rst_mem1;
    rst_mem3 <= rst_mem2;
    rst_pulse <= !rst_mem3 && rst_mem2;
  end


always @ (posedge clk100MHz)
  begin
    if (rst_pulse)
      begin
        count1next <= 1'b1;
        count2next <= 1'b1;
        clk_5KHz <= 1'b0;
        clk_4sec <= 1'b0;
      end
    else
      begin
        if (count1 == 32'd200000000)
          begin
            clk_4sec <= ~clk_4sec;
            count1next <= 1'b0;
          end
        else
          count1next <= count1 + 32'd1;

        if (count2 == 32'd10000)
          begin
            clk_5KHz <= ~clk_5KHz;
            count2next <= 1'b0;
          end
        else
          count2next <= count2 + 32'd1;
      end
  end

always @ (posedge clk100MHz)
  begin
    count1 <= count1next;
    count2 <= count2next;
  end
endmodule
