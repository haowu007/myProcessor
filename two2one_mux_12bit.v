// 12-bit 2-to-1 MUX
module two2one_mux_12bit(a, b, sel, out);

    input [11:0] a, b;
    input sel;
    output [11:0] out;
    
    assign out = sel ? b : a;

endmodule