module HazardDetecting (input EX_memread, eq, input [4:0] ID_rt, ID_rs, EX_rt, input [5:0] opc,
                         output pc_ld, IF_ID_reg_ld, hazard_detected, flush, is_beq, is_bne, is_jmp);
  
  //hazard_detected goes to sel of mux
  
  assign is_beq = (opc == 6'b000100) ? 1'b1 : 1'b0;
  assign is_bne = (opc == 6'b000101) ? 1'b1 : 1'b0;
  
  wire beq_cond, bne_cond;
  assign beq_cond = (is_beq && eq);
  assign bne_cond = (is_bne && ~eq);
  
  assign is_jmp = (opc == 6'b000010) ? 1'b1 : 1'b0;
  
  assign flush = (beq_cond || bne_cond || is_jmp) ? 1'b1 : 1'b0;
  
  wire lw_cond;
  assign lw_cond = ( ((ID_rt == EX_rt)||(ID_rs == EX_rt)) && EX_memread );

  assign hazard_detected = (flush || lw_cond) ? 1'b1 : 1'b0; 
  // 0 will go to control signals if hazard_detected is 1
  
  assign pc_ld = lw_cond ? 1'b0 : 1'b1;
  assign IF_ID_reg_ld = pc_ld;
  
endmodule


module HazardDetecting_TB();
  
  reg EX_memread = 0, eq = 0;
  reg [4:0] ID_rt, ID_rs, EX_rt;
  reg [5:0] opc;
  wire pc_ld, IF_ID_reg_ld, hazard_detected, flush;
  
  HazardDetecting UUT (EX_memread, eq, ID_rt, ID_rs, EX_rt, opc,
                       pc_ld, IF_ID_reg_ld, hazard_detected, flush);
  initial begin
    ID_rt = 5'd10;
    ID_rs = 5'd15;
    EX_rt = 5'd18;
    opc = 6'd0;
    #50;
    EX_memread = 1'b1;
    #50;
    ID_rt = 5'd18;
    #50;
    EX_memread = 0;
    #50;
    opc = 6'b000100;
    #50;
    eq = 1'b1;
    #50;
  end
endmodule