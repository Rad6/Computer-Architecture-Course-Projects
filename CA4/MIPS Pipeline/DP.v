`include "defs.v"

module DP( input clk, rst, ALUSrc, RegDst, input [2:0] alu_op,
           input MemWrite, MemRead,
           RegWrite, MemToReg, output [`LEN_INST-1:0] inst);
           
  wire is_beq, is_bne, is_jmp, eq, and1_out, and2_out, or1_out, pc_ld;
  and _and1( and1_out, is_beq, eq);
  and _and2( and2_out, is_bne, ~eq);
  or _or1( or1_out, and1_out, and2_out);
  
  wire [31:0] pc_in, pc_out, pc_plus4, mux_pc_out, jmp_adr, adder2_out;
  wire [31:0] inst_IF, inst_ID;
  
  mux2 #(32) _mux_pc ( pc_plus4, adder2_out, or1_out, mux_pc_out);
  
  assign jmp_adr = {pc_plus4[31:28] , inst_ID[25:0] , 2'b00};
  
  mux2 #(32) _mux_jmp ( mux_pc_out, jmp_adr, is_jmp, pc_in);
  
  PC _pc(pc_in, clk, rst, pc_ld, pc_out);
  
  adder #(32) adder1 (pc_out, 32'd4, pc_plus4);
  
  IM _im(pc_out, inst_IF);
  
  wire [31:0] pc_ID, imm_ID, left_shifted;
  wire  flush, IF_ID_write;
  Reg_IF_ID _Reg_IF_ID(clk, rst, flush, IF_ID_write, pc_plus4, inst_IF, pc_ID, inst_ID);
  SE _se( inst_IF[15:0] , imm_ID );
  
  assign left_shifted = imm_ID << 2;
  
  adder #(32) adder2 (left_shifted, PC_ID, adder2_out);
  
  wire [4:0]rt_EX;
  wire EX_memread, hazard_detected;
  HazardDetecting (EX_memread, eq, inst_ID[20:16], inst_ID[25:21], rt_EX, inst_ID[31:26],
                         pc_ld, IF_ID_write, hazard_detected, flush, is_beq, is_bne, is_jmp);
  
  wire [8:0] mux_ID_out;
  //sequence[8:0]: ALUsrc, ALUop[8:6], regDst, memread, memwrite, Regwrite, MemToReg               
  Mux2 #(9) _mux_ID({ALUSrc, alu_op, regDst, MemRead, MemWrite, RegWrite, MemToReg}, 9'b000000000, 
  hazard_detected, mux_ID_out);
  
  
  wire WB_writereg;
  wire [31:0] wr_data, RF1_out, RF2_out;
  
  RF _RF (
  clk, rst, WB_writereg,
  inst_ID[25:21], inst_ID[20:16], inst_ID[15:11],
  wr_data,
  RF1_out, RF2_out);

  BranchPredictor _BranchPredictor(RF1_out, RF2_out, eq);
  
  //wire controls_EX[3:0]; // [3:0] : memread, memwrite, Regwrite, MemToReg
  wire memread_EX, memwrite_EX, Regwrite_EX, MemToReg_EX, ALUSrc_EX, RegDst_EX;
  wire [2:0]ALUop_EX;
  wire [31:0] data1_EX, data2_EX, imm_EX;
  wire [4:0] rs_EX, rd_EX;

  Reg_ID_EX _reg_id_ex(
    clk, rst, 
    mux_ID_out[8], mux_ID_out[7:5], mux_ID_out[4], // EX
    mux_ID_out[3], mux_ID_out[2], mux_ID_out[1], //MEM
    mux_ID_out[0], // WB
    RF1_out, RF2_out,
    imm_ID,
    inst_ID[25:21], inst_ID[20:16], inst_ID[15:11],
    ALUSrc_EX, ALUop_EX, RegDst_EX,
    memread_EX, memwrite_EX, Regwrite_EX, MemToReg_EX,
    data1_EX, data2_EX,
    imm_EX,
    rs_EX, rt_EX, rd_EX);


  wire [31:0] data_mem_adr, ALU_A, ALU_B, mux_alu_B_out, ALU_out_EX; //
  wire [1:0] ForwardA, ForwardB;

  Mux3 #(32) _mux_alu_A (data1_EX, wr_data, data_mem_adr, ForwardA, ALU_A); 
                            
  Mux3 #(32) _mux_alu_B (data2_EX, wr_data, data_mem_adr, ForwardB, mux_alu_B_out);
                            
  Mux2 #(32) _mux_ALUSrc (mux_alu_B_out, imm_EX, ALUSrc_EX, ALU_B); 

  ALU _ALU( ALU_A, ALU_B, ALUop_EX, ALU_out_EX);

  wire [4:0] final_rd_EX;
  Mux2 #(5) _mux_RegDst (rt_EX, rd_EX, RegDst_EX, final_rd_EX);

  wire [4:0] rd_MEM, rd_WB;
  wire RegWrite_MEM;
  ForwardingUnit _ForwardingUnit(
    WB_writereg, rd_WB,
    RegWrite_MEM, rd_MEM, 
    rs_EX, rt_EX, ForwardA, ForwardB
  );

  //wire [4:0] final_rd_MEM;
  wire [31:0] that_MEM;
  wire MemRead_MEM, MemWrite_MEM, MemToReg_MEM;
  
  Reg_EX_MEM _Reg_EX_MEM(
    clk, rst,
    Regwrite_EX, MemToReg_EX, // WB
    memread_EX, memwrite_EX, //MEM
    ALU_out_EX,
    final_rd_EX,
    mux_alu_B_out,
    RegWrite_MEM, MemToReg_MEM, // WB
    MemRead_MEM, MemWrite_MEM, //MEM
    data_mem_adr, rd_MEM,
    that_MEM
  );

  wire [31:0] data_mem_out;
  MEM _mem(MemWrite_MEM, MemRead_MEM,
           data_mem_adr, 
           that_MEM, 
           data_mem_out);
           
  wire MemToReg_WB;      
  wire [31:0] data_mem_out_WB, data_mem_in_WB;
  
  Reg_MEM_WB _Reg_MEM_WB(
    clk, rst,
    RegWrite_MEM, MemToReg_MEM, // WB
    data_mem_out,
    data_mem_adr,
    rd_MEM,
    WB_writereg, MemToReg_WB, // WB
    data_mem_out_WB,
    data_mem_in_WB,
    rd_WB);
  
  Mux2 #(32) _mux_memtoreg (data_mem_in_WB, data_mem_out_WB, MemToReg_WB, wr_dara);
  
endmodule