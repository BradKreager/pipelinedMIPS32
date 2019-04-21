module signext (
		input  wire        ext_zero0_sign1,
        input  wire [15:0] a,
        output wire [31:0] y
    );

    assign y = ext_zero0_sign1 ? {{16{a[15]}}, a} : {{16{1'b0}}, a};
    
endmodule
