`timescale 1ns / 1ps

module fetch(

    );



dreg_sync_rst control_signals (
       .clk            (clk),
       .rst            (rst),
       .d              (jr_pc_next),
       .q              (pc_current)
); 
endmodule
