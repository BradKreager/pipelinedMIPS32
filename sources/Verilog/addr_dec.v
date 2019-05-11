`timescale 1ns / 1ps

module addr_dec(
    input we,
    input [31:0]a,
    
    output we_gpio,
    output we_fact,
    output we_mem,
    output [1:0]rd_sel
    );
    
    //Set up the address spaces for the various IPs
    wire gpio_select = (a >= 32'h900) & (a <= 32'h90C);
    wire fact_select = (a >= 32'h800) & (a <= 32'h80C);
    
    //This is a little cryptic, but I wanted to make sure this whole thing was combinational for maximum efficiency
    //If we're in the GPIO address range AND we is set, then select the GPIO IP
    assign we_gpio = ((gpio_select) & we) ? 1 : 0;
    //If we're in the factorial address range AND we is set, then select the factorial IP
    assign we_fact = ((fact_select) & we) ? 1 : 0;
    //If we're not writing to factorial or GPIO AND we is set, then write to memory
    assign we_mem =  ~gpio_select & ~fact_select & we ? 1 : 0;
    
    //Set the second rd_sel bit if we're in GPIO OR factorial address space
    assign rd_sel[1] = ((fact_select | gpio_select));
    //Set the first rd_sel bit if we're in GPIO address space
    assign rd_sel[0] = (gpio_select);
endmodule
