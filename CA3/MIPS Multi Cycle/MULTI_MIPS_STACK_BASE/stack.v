module stack(input clk, rst, tos, push, pop, [7:0] d_in, output reg [7:0] d_out);
  
  reg [7:0] data[31:0];
  integer head;
  
  always @(posedge clk, posedge rst)
  begin
    if (rst) head = 0;
    if (push == 1 && head != 31)
      begin
        data[head] = d_in;
        head = head + 1;
        $display("push : %d %d", head, data[head]);
      end
      
    else if (pop == 1 && head != 0)
      begin
        head = head - 1;
        d_out = data[head];
        $display("pop  : %d %d", head, data[head]);
      end
      
    else if (tos == 1 && head != 0)
      d_out = data[head - 1]; 
    end
    
  endmodule
