module HazardDetecting ( input [4:0] ID_rt, ID_rs, EX_rt, input EX_memread, output hazard_detected);
  wire cond;
  assign cond = (ID_rt == EX_rt) || (ID_rs == EX_rt) ? 1'b1 : 1'b0;
  assign hazard_detected = (EX_memread && cond) ? 1'b0 : 1'b1;
endmodule
