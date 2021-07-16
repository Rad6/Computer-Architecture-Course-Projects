// the last and top module
module MIPS(input clk, rst);
  // connecting datapath with controller here
  wire[2:0] inst;
  wire[1:0] AluOp;
  wire PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite, MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS;
  DP DP(clk, rst, PcWrite, PcWriteC, PcSrc, PorI, MemRead, MemWrite,
  IRWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS, AluOp, inst);

   Controller CU(clk, rst, inst,
                  PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite,
                  MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS,
                  AluOp); 
  
endmodule



module TB_MIPS();

  reg clk = 0, rst = 0;
  MIPS UUT(clk, rst);
  always #10 clk = ~clk;
  initial begin
    rst = 1;
    #5
    rst = 0;
    #500000 $stop;
  end

endmodule