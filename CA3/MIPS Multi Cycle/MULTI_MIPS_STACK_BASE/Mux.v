module mux #(parameter n) (input  [n-1:0] x, y,
                            input sel,
                            output  [n-1:0] out); 
assign out = (sel == 1'b0) ? x : y;
endmodule


