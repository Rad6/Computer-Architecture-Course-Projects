module mem_tb();
  
  reg [4:0] adr;
  reg [7:0] data;
  reg sig_write = 0, sig_read = 0;
  wire [7:0] out;
  MEM UUT(adr, data, sig_write, sig_read, out);
  
  initial begin
    adr = 5'd0;
    sig_read = 1;
    #100;
    adr = 5'd1;
    #100;
    adr = 5'd2;
    #100;
    adr = 5'd3;
    #100;
    adr = 5'd4;
    #100;
    adr = 5'd10;
    sig_read = 0;
    sig_write = 1;
    data = 8'b10101010;
    #100;
    adr = 5'd13;
    data = 8'b11110000;
    #100;
    sig_write = 0;
    sig_read = 1;
    #100;
    
  end
endmodule