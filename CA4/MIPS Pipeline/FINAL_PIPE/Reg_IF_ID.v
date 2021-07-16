`include "defs.v"

module Reg_IF_ID(
    input clk, rst, flush, write,
    input [`LEN_PC-1:0] i_pc, 
    input [`LEN_INST-1:0] i_inst,
    output reg [`LEN_PC-1:0] o_pc, 
    output reg [`LEN_INST-1:0] o_inst
);


    always @(posedge clk) begin

        if(rst) begin
            o_pc <= 0;
            o_inst <= 0;
        end
        else begin
            if(write) begin

                if(flush) begin
                    o_inst <= 0;
                    // o_pc <= 0;
                end
                else begin
                    o_inst <= i_inst;
                    o_pc <= i_pc;
                end

            end
        end
        
    end

endmodule