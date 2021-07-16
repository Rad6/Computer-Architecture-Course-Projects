module stack_TB();
  
  wire [7:0] d_out;
  reg [7:0] d_in;
  reg clk = 0, tos = 0,push = 0, pop = 0;
  stack UUT (clk, tos, push, pop,d_in,d_out);
  
  always #20 clk = ~clk;
  
  initial begin
    d_in = 8'b10000000;
    #100;
    push = 1;
    #40;
    push = 0;
    d_in = 8'b01010101;
    #100;
    push = 1;
    #40;
    push = 0;
    #100;
    tos = 1;
    #100;
    pop = 1;
    #100;
    pop = 0;
    #1000;
    $stop;
  end
endmodule
  


