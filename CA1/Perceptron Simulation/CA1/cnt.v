module cnt(input clk, rst, enable, load, output reg [7:0]out, output cout);
// 0 to 199 counter
  
  always @(posedge clk, posedge rst) begin
    if (rst) out <= 8'b00000000;
    else begin
      if (load) out <= 8'b00000000;
      else if (enable) begin
            if ((out == 8'b11000111))out <= 8'b00000000;
            else out <= out + 1;
      end
      // else if ((out == 8'b11000111) && enable ) out <= 8'b00000000;
      // else if (enable) out <= out + 1;
      // else if (~enable) out <= out;
    end
  end
  
  assign cout = ((out == 8'b11000111)) ;
  
endmodule
    

