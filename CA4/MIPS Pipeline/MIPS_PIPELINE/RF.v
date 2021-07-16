`include "defs.v"

module RF (
  input clk, rst, write,
  input  [`LEN_INST_REG-1:0] r1, r2, rd,
  input  [`LEN_DATA-1:0] data,
  output [`LEN_DATA-1:0] out1, out2
); 


  integer i;
  reg [`LEN_DATA-1:0] mem [0:`SIZE_RF-1];

  assign out1 = mem[r1];
  assign out2 = mem[r2];

  always @(negedge clk) begin
    mem[0] <= 0;
    if(rst) begin
      for(i=0; i<`SIZE_RF; i=i+1) mem[i] <=0;
    end
    else begin
      if(write) mem[rd] <= data;
    end
  end


endmodule



module TB_RF();
  reg clk = 0, rst = 0, write = 0;
  reg [`LEN_INST_REG-1:0] r1,r2,rd;
  reg [`LEN_DATA-1:0] data;
  wire [`LEN_DATA-1:0] out1, out2;

  always #10 clk = ~clk;
  RF UUT(clk, rst, write, r1, r2, rd, data, out1, out2);

  initial begin
    rst = 1;
    #5 
    rst = 0;
    #15
    r1 = 0; r2 = 12; rd = 15;
    #15
    write = 1; data = 52;
    #23
    write = 0;
    r1 = 15;
    #23
    write = 1;
    rd = 0;
    data = 624;
    #23
    write = 0;
    r1 = 0;
    #100 $stop;
  end




endmodule