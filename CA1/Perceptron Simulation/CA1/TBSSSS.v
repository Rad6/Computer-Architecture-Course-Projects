module Multiplier_TB();

  parameter n = 3;
  reg [n-1:0] x = 3'b101, y = 3'b010;
  wire[2*n-1:0] out;

  multiplier #(n) UUT (x, y, out);
  
  initial begin
    #200;
    x = 3'b000;
    #200;
    y = 3'b001;
    #100;
    $stop;
  end

endmodule




module SignExtend_TB();

  parameter n = 3 , m = 3 , p = 4;
  reg [n-1:0] x = 3'b101;
  wire[m+n+p-1:0] out;

  signExtend #(n,m,p) UUT (x, out);
  
  initial begin
    #200;
    x = 3'b010;
    #200;
    $stop;
  end

endmodule



module splitting_TB();


  reg clk = 0, rst = 0, ld_shit1 = 0 , ld_shit2 = 0;
  wire signed [3:0] out1; wire signed [5:0] out2;


  SuperTest UUT(clk,rst,ld_shit1,ld_shit2,out1,out2);

  always #20 clk = ~clk;

  initial begin
        #10; rst = 1;
        #50; rst = 0;
        #50; ld_shit1 = 1; ld_shit2 = 1;
        #40000 $stop;
    end

endmodule


module comparator_TB();

reg signed [13:0] x = 14'b00000000000000;
reg signed [1:0] y = 2'b01;
wire out;

comparator UUT(.x(x), .y(y), .out(out));

initial begin
#10; x = 14'b10000000000000;

#10; y = 2'b11;

#100 $stop;

end

endmodule