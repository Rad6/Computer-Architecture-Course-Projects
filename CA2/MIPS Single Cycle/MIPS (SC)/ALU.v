module ALU(input [15:0] A, B, input [2:0] sig_op, output zero, output reg [15:0] out);
  always @(sig_op, A, B)
  case (sig_op)
    0 : out <= B + 16'b0;
    1 : out <= A + B;
    2 : out <= A - B;
    3 : out <= A && B;
    4 : out <= A || B;
    5 : out <= ~B;
    6 : out <= out;
    default : out <= out;
  endcase
  assign zero = ((A - B) == 0);
endmodule
    
// 8'b00000001
// 8'b00000010
// 8'b00000100
// 8'b00001000
// 8'b00010000
// 8'b00100000
// 8'b01000000