module Mux2 #(parameter n) (input signed [n-1:0] x, y,
                            input sel,
                            output signed [n-1:0] out); 
assign out = (sel == 1'b0) ? x : y;
endmodule


module Mux3 #(parameter n) (input signed [n-1:0] x, y, z,
                            input[1:0] sel,
                            output signed [n-1:0] out); 
assign out = (sel == 2'b00) ? x : (sel == 2'b01)? y : z;
endmodule


