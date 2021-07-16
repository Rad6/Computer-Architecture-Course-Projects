`include "defs.v"

module PC(input[`LEN_PC-1:0] in, input clk, rst, ld, output reg [`LEN_PC-1:0] out);
    always @(posedge clk, posedge rst)begin
        if(rst) out = 5'b0;   
        else if (ld) out <= in;
    end
endmodule
