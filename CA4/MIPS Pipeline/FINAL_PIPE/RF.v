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