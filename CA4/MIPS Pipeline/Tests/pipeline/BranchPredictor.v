module BranchPredictor (input [31:0] A, B, output eq);
  assign eq = ( A == B ) ? 1'b1 : 1'b0;
endmodule
