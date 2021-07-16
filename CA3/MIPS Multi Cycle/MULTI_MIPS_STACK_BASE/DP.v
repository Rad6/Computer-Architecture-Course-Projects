module DP( input clk, rst, pcwrite, pcwritecond, pcsrc, PorI, memread, memwrite,
  IRwrite, MtoS, ldA, ldB, srcA, srcB, push, pop, tos,input [1:0]ALUop, output [2:0] opc);
  
  wire and_out, or_out, zero;
  wire [4:0] pc_in, pc_out, mux5_in, mem_in;
  wire [7:0] mem_out, IR_out, mdr_out, st_in, st_out, A_out, B_out, SE_out, mux3_out, mux4_out, ALU_out, ALUreg_out;
  
  and(and_out, zero, pcwritecond);
  or(or_out, and_out, pcwrite);
  
  PC _pc (pc_in, clk, rst, or_out, pc_out);
  
  mux #(5) mux1(pc_out, IR_out[4:0], PorI, mem_in);
  
  MEM _mem(mem_in, A_out, memwrite, memread, mem_out);
  
  register #(8) IR(mem_out, clk, IRwrite, rst, IR_out);
  register_without_ld  #(8) MDR(mem_out, clk, rst, mdr_out);
  
  mux #(8) mux2(ALUreg_out, mdr_out, MtoS, st_in);
  
  stack _st(clk, rst, tos, push, pop, st_in, st_out);
  
  register #(8) A(st_out, clk, ldA, rst, A_out);
  register #(8) B(st_out, clk, ldB, rst, B_out);
  
  IfZero  #(8) _zero( st_out, zero);
  
  SE _se( pc_out, SE_out );
  
  mux #(8) mux3(A_out, SE_out, srcA, mux3_out);
  mux #(8) mux4(B_out, 8'b00000001 , srcB, mux4_out);
  
  ALU _alu(mux3_out, mux4_out, ALUop, ALU_out);
  
  register_without_ld  #(8) ALUreg(ALU_out, clk, rst, ALUreg_out);
  
  mux #(5) mux5(ALU_out[4:0], IR_out[4:0], pcsrc, pc_in);
  
  assign opc = IR_out[7:5];
  
endmodule
