`include "defs.v"

module Reg_EX_MEM(
    input clk, rst,
    input i_RegWrite, i_MemToReg, // WB
    input i_MemRead, i_MemWrite, //MEM
    input [`LEN_DATA-1:0] i_alu,
    input [`LEN_INST_REG-1:0] i_reg,
    input [`LEN_DATA-1:0] i_that,
    output reg o_RegWrite, o_MemToReg, // WB
    output reg o_MemRead, o_MemWrite, //MEM
    output reg [`LEN_DATA-1:0] o_alu,
    output reg [`LEN_INST_REG-1:0] o_reg,
    output reg [`LEN_DATA-1:0] o_that
);

always @(posedge clk) begin
    if(rst)begin
        {o_RegWrite, o_MemToReg, o_MemRead, o_MemWrite } <= 0;
        o_alu <= 0;
        o_reg <= 0;
        o_that <= 0;
    end
        
    else begin
        o_RegWrite <= i_RegWrite;
        o_MemToReg <= i_MemToReg;
        o_MemRead <= i_MemRead;
        o_MemWrite <= i_MemWrite;
        o_alu <= i_alu;
        o_reg <= i_reg;
        o_that <= i_that;
    end


end

endmodule