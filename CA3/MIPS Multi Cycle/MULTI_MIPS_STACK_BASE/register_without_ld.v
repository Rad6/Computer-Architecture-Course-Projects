module register_without_ld  #(parameter n) ( input [n-1:0]data,
                                  input clk,
                                  input rst,
                                  output reg [n-1:0] out);
 
   always @ (posedge clk , posedge rst) begin
      if (rst)
         out <= 0;
      else out <= data;
    end
endmodule


