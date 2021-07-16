`include "defs.v"

module Reg_ID_EX(
    input clk, rst, 
    input i_ALUSrc, input [2:0] i_ALUop, input i_RegDst, // EX
    input i_MemRead, i_MemWrite, i_PCSrc, //MEM
    input i_RegWrite, i_MemToReg, // WB
    input [`LEN_DATA-1:0] i_data1, i_data2,
    input [`LEN_DATA-1:0] i_imm,
    input [`LEN_INST_REG-1:0] i_rs, i_rt, i_rd,
    output reg o_ALUSrc, output reg [2:0] o_ALUop, output reg o_RegDst,
    output reg o_MemRead, o_MemWrite, o_PCSrc, 
    output reg o_RegWrite, o_MemToReg,
    output reg [`LEN_DATA-1:0] o_data1, o_data2,
    output reg [`LEN_DATA-1:0] o_imm,
    output reg [`LEN_INST_REG-1:0] o_rs, o_rt, o_rd
);

    always @(posedge clk) begin

        if(rst) begin 
            o_ALUop <= 3'b000;
            {o_ALUSrc, o_RegDst} <= 0;
            {o_MemRead, o_MemWrite, o_PCSrc, o_RegWrite, o_MemToReg} <= 0;
            {o_data1, o_data2} <= 0;
            {o_rs, o_rt, o_rd} <= 0;
            o_imm <= 0;
        end
        else begin
            o_ALUSrc <= i_ALUSrc;
            o_ALUop <= i_ALUop; 
            o_RegDst <= i_RegDst; 
            o_MemRead <= i_MemRead;
            o_MemWrite <= i_MemWrite;
            o_PCSrc <= i_PCSrc;
            o_RegWrite <= i_RegWrite;
            o_MemToReg <= i_MemToReg;
            o_data1 <= i_data1; 
            o_data2 <= i_data2;
            o_rs <= i_rs; 
            o_rt <= i_rt; 
            o_rd <= i_rd;
            o_imm <= i_imm;
        end

    end

endmodule