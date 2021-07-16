`include "defs.v"

module DP(
  input clk, rst, 
  input [`LEN_ADR-1:0] adr,
  output done,
  output reg [12:0] hit_cnt, 
  output [`LEN_DATA-1:0] o_data
);
  
  wire [127:0] data_128_bit;
  wire write, read, mem_ready, hit;
  wire [`LEN_DATA-1:0] mem_in_data;
  // wire [`LEN_ADR-1:0] adr;
  
  MEM _mem(
    write, read,
    adr, 
    mem_in_data, 
    mem_ready,
    data_128_bit
  );

  
  Cache _cache(
    clk, rst, write,
    data_128_bit,
    adr,
    hit,
    o_data
  );

  Cach_CU _cache_cu(
    clk, rst,
    hit, mem_ready,
    read, done, write
  );
  
  always @(posedge clk, posedge rst) begin
    if (rst) hit_cnt <= 0;
    else if(hit && done) hit_cnt <= hit_cnt + 1;
  end
  
  
endmodule





module TB();
  
  reg clk = 0 , rst = 0;
  wire [12:0] hit_cnt;
  wire [`LEN_DATA-1:0] o_data;
  reg [`LEN_ADR-1:0] adr = 0;
  wire done;
  
  DP UUT(
  clk, rst, 
  adr, done,
  hit_cnt, 
  o_data
);
  
  
  always #20 clk = ~clk;

  always @(posedge clk, posedge rst) begin
    if (rst) adr <= 15'd1000;
    else if (done) adr <= adr + 1;
    end
    
  initial begin
    rst = 1;
    #10; 
    rst = 0;
    #100000; $stop;  
  end
endmodule

