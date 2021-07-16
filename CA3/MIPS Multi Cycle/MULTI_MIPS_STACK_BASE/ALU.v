module ALU(input [7:0] A, B, input [1:0] sig_op, output reg [7:0] out);
  always @(sig_op, A, B)
  case (sig_op)
    0 : out <= A + B;
    1 : out <= ‌B - A;
    2 : out <= A & B;
    3 : out <= ~A;
    default : out <= out;
  endcase
endmodule
