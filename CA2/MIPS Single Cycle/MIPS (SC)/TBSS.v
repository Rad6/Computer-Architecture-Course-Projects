module RegFile_TB();

  wire[15:0] out1, out2;
  reg [15:0] data = 29;
  reg [1 :0] in1=2'b00, in2=2'b00, writereg = 2'b01;
  reg [2 :0] sig_window = 3'b010;
  reg        sig_write = 1'b0;
  
  RF UUT( .n1(in1), .in2(in2), .wrR(writereg),
                .sig_wnd(sig_window), .data(data),
                .sig_write(sig_write), .out1(out1), .out2(out2));

  initial begin
    #10; sig_write = 1'b1;
    #10; sig_write = 1'b0;
    #50; in1=2'b01; 

    #100; $stop;
  end

endmodule



module PC_TB();

  reg clk = 1'b0, rst = 1'b0;
  reg[9:0] _in = 134;
  wire[9:0] _out;
  PC UUT (.in(_in), .clk(clk), .rst(rst), .out(_out));
  always #20 clk=~clk;

  initial begin
    #10; rst=1'b1;
    #13; rst=1'b0;
    #60; _in=12;
    #40; $stop;
  end

endmodule



module IM_TB();
  reg [9:0] _adr=2;
  wire[15:0] _out;

  IM UUT(.adr(_adr), .inst(_out));

  initial begin
    #10; _adr=4;
    #10; _adr=40;
    #10; _adr=1;
    #10; $stop;
  end

endmodule


module MEM_TB();
  
  reg [9:0] _adr = 12;
  reg [15:0] _data = 196;
  reg _sig_write=1'b0, _sig_read=1'b0;
  wire[15:0] _out;

  MEM UUT(.adr(_adr), .data(_data), .sig_write(_sig_write),
         .sig_read(_sig_read), .out(_out));

  initial begin
    #10; _sig_read=1'b1; #10; _sig_read=1'b0;
    #10; _sig_write=1'b1; #10; _sig_write=1'b0;
    #10; _sig_read=1'b1; #10; _sig_read=1'b0;
    #10; _adr = 555;
    #10; _sig_read=1'b1; #10; _sig_read=1'b0;
    #10; _sig_write=1'b1; _data=3; #10; _sig_write=1'b0;
    #10; _sig_read=1'b1; _adr=12;
    #10; _adr = 555;
    #10; _sig_read = 1'b0;
    #50; $stop;
  end

endmodule




module FILEREADER_TB();

  reg [15:0] mem[0:100];
  integer i;

  initial begin
    #10
    $readmemb("instructions.txt", mem);
    for(i=0;i<100;i=i+1) begin
      $display("%b", mem[i]);
    end
    #10; $stop;
  end

endmodule