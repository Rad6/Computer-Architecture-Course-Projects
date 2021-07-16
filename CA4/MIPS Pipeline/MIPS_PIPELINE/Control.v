`include "defs.v"

//this module controls aluop and mux signals.

module Control(
    input [`LEN_INST-1:0] inst,
    output reg ALUSrc, RegDst, output reg [2:0] alu_op, //EX
    output reg PCSrc, , MemWrite, MemRead, //MEM
    output reg RegWrite, MemToReg //WB
);

    always @(inst) begin
        {ALUSrc, RegDst} <= 0;
        alu_op <= `ALU_NO;
        {PCSrc, , MemWrite, MemRead} <= 0;
        {RegWrite, MemToReg} <= 0;

        case (inst[31:26])
            `OPC_R_TYPE : begin
                case (inst[5:0])
                    `FUNC_ADD: alu_op <= `ALU_ADD;
                    `FUNC_SUB: alu_op <= `ALU_SUB;
                    `FUNC_AND: alu_op <= `ALU_AND;
                    `FUNC_OR : alu_op <= `ALU_OR ;
                    `FUNC_SLT: alu_op <= `ALU_SLT;
                    `FUNC_NOP: alu_op <= `ALU_NO ;
                    default  : alu_op <= `ALU_NO ;
                endcase
                RegDst   <= 1;
                RegWrite <= 1;
                ALUSrc   <= 0;
                MemWrite <= 0;
                MemRead  <= 0;
                MemToReg <= 0;
                PCSrc    <= 0;
            end

            `OPC_LW : begin
                alu_op   <= `ALU_ADD;
                RegDst   <= 0;
                RegWrite <= 1;
                ALUSrc   <= 1;
                MemWrite <= 0;
                MemRead  <= 1;
                MemToReg <= 1;
                PCSrc    <= 0;
            end

            `OPC_SW : begin
                alu_op   <= `ALU_ADD;
                RegDst   <= 0; //DC
                RegWrite <= 0;
                ALUSrc   <= 1;
                MemWrite <= 1;
                MemRead  <= 0;
                MemToReg <= 1; //DC
                PCSrc    <= 0;
            end
            
            `OPC_J  :begin
                RegDst   <= 0; //DC
                RegWrite <= 0;
                ALUSrc   <= 0;
                alu_op   <= 3'b111;
                MemWrite <= 0;
                MemRead  <= 0;
                MemToReg <= 0;
                MemToReg <= 0; //DC
            end

            `OPC_BEQ:begin
                RegDst   <= 0; //DC
                RegWrite <= 0;
                ALUSrc   <= 0;
                alu_op   <= 3'b111;
                MemWrite <= 0;
                MemRead  <= 0;
                MemToReg <= 0;
                MemToReg <= 0; //DC
            end

            `OPC_BNE:begin
                RegDst   <= 0; //DC
                RegWrite <= 0;
                ALUSrc   <= 0;
                alu_op   <= 3'b111;
                MemWrite <= 0;
                MemRead  <= 0;
                MemToReg <= 0;
                MemToReg <= 0; //DC
            end


            default: 
        endcase    

    end

endmodule