module adder #(parameter n) (input signed [n-1:0] x, y, output [n-1:0] out);
    assign out = x + y;
endmodule 
