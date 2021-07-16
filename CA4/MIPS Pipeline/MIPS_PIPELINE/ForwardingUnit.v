// `include "defs.v"

// module ForwardingUnit(
//     input MEM_WB_RegWrite, input[`LEN_INST_REG-1:0] MEM_WB_Rd,
//     input EX_MEM_RegWrite, input[`LEN_INST_REG-1:0] EX_MEM_Rd, 
//     input[`LEN_INST_REG-1:0] ID_EX_Rs, ID_EX_Rt,
//     output reg [1:0] ForwardingA, ForwardingB
// );

// always @(MEM_WB_RegWrite, MEM_WB_Rd, EX_MEM_RegWrite, EX_MEM_Rd, ID_EX_Rs, ID_EX_Rt) begin

//     if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
//       (!((EX_MEM_RegWrite) && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs))))
//       ForwardingA <= 2'b01;
    
//     if((MEM_WB_RegWrite) && (MEM_WB_Rd != 0) && 
//       (!((EX_MEM_RegWrite) && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rt))))
//       ForwardingB <= 2'b01;
// end

// endmodule


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


module TB_ForwardingUnit();
  reg MEM_WB_RegWrite; reg[`LEN_INST_REG-1:0] MEM_WB_Rd;
  reg EX_MEM_RegWrite; reg[`LEN_INST_REG-1:0] EX_MEM_Rd; 
  reg [`LEN_INST_REG-1:0] ID_EX_Rs, ID_EX_Rt;
  wire [1:0] ForwardingA, ForwardingB;
  ForwardingUnit UUT(
    MEM_WB_RegWrite, MEM_WB_Rd,
    EX_MEM_RegWrite, EX_MEM_Rd, 
    ID_EX_Rs, ID_EX_Rt,
    ForwardingA, ForwardingB
  );



  initial begin
    #10
    ID_EX_Rt = 13; ID_EX_Rs = 10;
    MEM_WB_RegWrite = 1; MEM_WB_Rd = 10;
    EX_MEM_RegWrite = 0; EX_MEM_Rd = 13;

    #50

    ID_EX_Rt = 13; ID_EX_Rs = 10;
    MEM_WB_RegWrite = 1; MEM_WB_Rd = 10;
    EX_MEM_RegWrite = 1; EX_MEM_Rd = 13;


    #100 $stop;

  end

endmodule