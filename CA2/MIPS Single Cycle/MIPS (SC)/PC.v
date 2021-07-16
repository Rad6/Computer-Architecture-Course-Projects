module PC(input[9:0] in, input clk, rst, output reg [9:0] out);
    always @(posedge clk, posedge rst)begin
        if(rst) out = 10'b0;   
        else out <= in;
    end
endmodule