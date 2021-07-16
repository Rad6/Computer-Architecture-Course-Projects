module register  #(parameter n) ( input [n-1:0]data,
                                  input clk,
                                  input ld,
                                  input rst,
                                  output reg [n-1:0] out);
 
   always @ (posedge clk , posedge rst) begin
      if (rst)
         out <= 0;
      else begin
         if (ld) out <= data;
      end
    end
endmodule
