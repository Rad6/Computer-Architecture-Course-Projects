module register  #(parameter n) ( input signed [n-1:0]data,
                                  input clk,
                                  input ld,
                                  input rst,
                                  input init0,
                                  output reg signed [n-1:0] out);
 
   always @ (posedge clk , posedge rst)
      if (rst)
         out <= 0;
      else begin
         if (init0) out <= 0;
         else if (ld)
            out <= data;
      end
endmodule
