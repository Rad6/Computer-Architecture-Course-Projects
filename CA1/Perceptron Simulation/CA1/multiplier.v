module multiplier #(parameter n) (input signed [n-1:0] x, y, output signed [2*n-1:0] out);
    assign out = x * y;
endmodule