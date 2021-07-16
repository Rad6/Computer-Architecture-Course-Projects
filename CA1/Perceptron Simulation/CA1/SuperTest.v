module SuperTest(input clk, rst, ld_shit1, ld_shit2, output signed [3:0] out1 ,output signed [5:0] out2);
 

wire signed [15:0] test = 16'b0001101000100101;
wire signed [3:0] shit1 = test[11:8];
wire signed [5:0] shit2 = test[6:1];


register #(4) reg_shit1(.data(shit1),.clk(clk),.ld(ld_shit1),.rst(rst),.out(out1)); 
register #(6) reg_shit2(.data(shit2),.clk(clk),.ld(ld_shit2),.rst(rst),.out(out2)); 


endmodule
