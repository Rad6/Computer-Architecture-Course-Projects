`include "defs.v"


module Pipeline(
  input clk, rst
);



wire MemWrite, MemRead, RegWrite, MemToReg, RegDst, ALUSrc;
wire PCSrc;
wire [2:0] alu_op;
wire [`LEN_INST-1:0] inst;

DP dp( 
  clk, rst, ALUSrc, RegDst, alu_op,
  MemWrite, MemRead, RegWrite, MemToReg, 
  inst
);
           
Control cu(
    inst,
    ALUSrc, RegDst, alu_op, //EX
    PCSrc, MemWrite, MemRead, //MEM
    RegWrite, MemToReg //WB
);           
           
endmodule



module TB_PIPELINE();
  
  reg clk = 0, rst = 0;
  always #10 clk = ~clk;
  
  Pipeline UUT(clk, rst);
  
  initial begin
    rst = 1;
    #4
    rst = 0;
    
    
    
    #10000 $stop;
      
  end
  
endmodule