module signExtend #(parameter n,m,p) (input signed [n-1:0] x, output signed [n+m+p-1:0] out);

assign out = {{m{x[n-1]}},x[n-1:0],{p{1'b0}}};

endmodule
