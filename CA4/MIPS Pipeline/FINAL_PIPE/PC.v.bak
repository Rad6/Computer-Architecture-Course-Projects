`include "defs.v"

module PC(input clk, rst, 
          input[`LEN_PC-1:0] in, 
          output reg [`LEN_PC-1:0] out);
    always @(posedge clk, posedge rst)begin
        if(rst) out = 0;   
        else out <= in;
    end
endmodule