
`include "defs.v"

module ForwardingUnit(
    input MEM_WB_RegWrite, input[`LEN_INST_REG-1:0] MEM_WB_Rd,
    input EX_MEM_RegWrite, input[`LEN_INST_REG-1:0] EX_MEM_Rd, 
    input[`LEN_INST_REG-1:0] ID_EX_Rs, ID_EX_Rt,
    output reg [1:0] ForwardingA, ForwardingB
);

always @(*) begin
  
    {ForwardingA, ForwardingB} <= 0;
    
    if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
      ~(EX_MEM_RegWrite) && (MEM_WB_Rd == ID_EX_Rs))
      ForwardingA <= 2'b01;
    
    if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
      ~(EX_MEM_RegWrite) && (MEM_WB_Rd == ID_EX_Rt))
      ForwardingB <= 2'b01;
    
    if((EX_MEM_RegWrite) && (EX_MEM_Rd != 0) && 
      ~(MEM_WB_RegWrite) && (EX_MEM_Rd == ID_EX_Rs))
      ForwardingA <= 2'b10;
      
    if((EX_MEM_RegWrite) && (EX_MEM_Rd != 0) && 
      ~(MEM_WB_RegWrite) && (EX_MEM_Rd == ID_EX_Rt))
      ForwardingB <= 2'b10;
      
    if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
      (EX_MEM_RegWrite) && (MEM_WB_Rd == ID_EX_Rs))
      ForwardingA <= 2'b10;
    
    if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
      (EX_MEM_RegWrite) && (MEM_WB_Rd == ID_EX_Rt))
      ForwardingB <= 2'b10;
    
end

endmodule
