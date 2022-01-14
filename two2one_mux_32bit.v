

// 32-bit 2-to-1 MUX
module two2one_mux_32bit(a, b, sel, out);

    input [31:0] a, b;
    input sel;
    output [31:0] out;
    
    assign out = sel ? b : a;

endmodule