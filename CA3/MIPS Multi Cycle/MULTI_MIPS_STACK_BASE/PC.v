module PC(input[4:0] in, input clk, rst, ld, output reg [4:0] out);
    always @(posedge clk, posedge rst)begin
        if(rst) out = 5'b0;   
        else if (ld) out <= in;
    end
endmodule