`include "defs.v"

module Reg_MEM_WB(
    input clk, rst,
    input i_RegWrite, i_MemToReg, // WB
    input [`LEN_DATA-1:0] i_mem_data,
    input [`LEN_DATA-1:0] i_alu_data,
    input [`LEN_INST_REG-1:0] i_rd,
    output reg o_RegWrite, o_MemToReg, // WB
    output reg [`LEN_DATA-1:0] o_mem_data,
    output reg [`LEN_DATA-1:0] o_alu_data,
    output reg [`LEN_INST_REG-1:0] o_rd
);

    always @(posedge clk) begin

        if(rst) begin
            o_RegWrite <= 0;
            o_mem_data <= 0;
            o_alu_data <= 0;
            o_MemToReg <= 0;
            o_rd <= 0;
        end

        else begin
            o_RegWrite <= i_RegWrite;
            o_MemToReg <= i_MemToReg;
            o_mem_data <= i_mem_data;
            o_alu_data <= i_alu_data;
            o_rd <= i_rd;
        end

    end

endmodule