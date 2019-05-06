module clk_gen (
        input  wire clk100MHz,
        input  wire rst,
        output reg  clk_4sec,
        output reg  clk_5KHz
    );

    integer count1, count2;
	reg rst_pulse, pulsemem1, pulsemem2;//, pulsemem3;

	always @ (posedge clk100MHz) begin
		pulsemem1 <= rst;
		pulsemem2 <= pulsemem1;
		// pulsemem3 <= pulsemem2;
		rst_pulse <= ~pulsemem2 & pulsemem1;
	end
	

    always @ (posedge clk100MHz) begin
        if (rst_pulse) begin
            count1 = 0;
            count2 = 0;
            clk_5KHz = 0;
            clk_4sec = 0;
        end
        else begin
            if (count1 == 200000000) begin
                clk_4sec = ~clk_4sec;
                count1 = 0;
            end

            if (count2 == 10000) begin
                clk_5KHz = ~clk_5KHz;
                count2 = 0;
            end

            count1 = count1 + 1;
            count2 = count2 + 1;            
        end
    end

endmodule
