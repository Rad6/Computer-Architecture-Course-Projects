module adder #(parameter n) (input signed [n-1:0] x, y, output signed [n-1:0] out);
    assign out = x + y;
endmodule 
