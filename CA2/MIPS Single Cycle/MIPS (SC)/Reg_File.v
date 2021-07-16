module RF(input [1:0] in1, in2, wrR, input [2:0] sig_wnd, 
                input [15:0] data, input sig_write,
                output reg [15:0] out1, out2);
 
 reg [15:0] mem [0:7];

 always @(sig_write, in1, in2, sig_wnd)
 begin
   if (sig_write)
     begin
       mem[ sig_wnd + {1'b0, wrR} ] = data;
     end
     else
       begin
         out1 = mem[sig_wnd + {1'b0 , in1}];
         out2 = mem[sig_wnd + {1'b0 , in2}];
       end
     end
endmodule

