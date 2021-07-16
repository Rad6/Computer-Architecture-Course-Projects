module Mux2_TB();

  parameter n = 3;
  reg signed [n-1:0] x = 3'b101, y = 3'b010;
  reg sel = 1'b1;
  wire signed [n-1:0] out;

  Mux2 #(n) UUT(x, y, sel, out);
  
  initial begin
    #200;
    sel = 1'b0;
    #200;
    sel = 1'b1;
    #100;
    $stop;
  end

endmodule



module Mux3_TB();

  parameter n = 3;
  reg [n-1:0] x = 3'b101, y = 3'b010 , z = 3'b111;
  reg [1:0] sel = 2'b00;
  wire[n-1:0] out;

  Mux3 #(n) UUT (x, y, z, sel, out);
  
  initial begin
    #200;
    sel = 2'b01;
    #200;
    sel = 2'b10;
    #100;
    $stop;
  end

endmodule