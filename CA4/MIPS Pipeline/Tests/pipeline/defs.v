

`define SIZE_MEM 1024


`define LEN_INST 32
`define LEN_DATA 32
`define SIZE_RF 32


`define LEN_IMM 16
`define LEN_OPCODE 6
`define LEN_INST_REG 5
`define LEN_FUNC 6


`define LEN_PC 32
`define LEN_ADR_MEM 10


// R-type
`define OPC_R_TYPE 6'b000000 

// lw, sw
`define OPC_LW 6'b100011
`define OPC_SW 6'b101011

//j, beq, bne
`define OPC_J   6'b000010
`define OPC_BEQ 6'b000100
`define OPC_BNE 6'b000101

//R format Functions : add, sub, and, or, slt
`define FUNC_ADD 6'b100000
`define FUNC_SUB 6'b100010
`define FUNC_AND 6'b100100
`define FUNC_OR  6'b100101
`define FUNC_SLT 6'b101010
`define FUNC_NOP 6'b000000

//ALU stuff
`define ALU_ADD 3'b001
`define ALU_SUB 3'b010
`define ALU_AND 3'b011
`define ALU_OR  3'b100
`define ALU_SLT 3'b111
`define ALU_NO  3'b110