module SE_TB();
  
  wire [7:0] eight_bit_out;
  reg [4:0] five_bit_in;
  SE UUT( five_bit_in, eight_bit_out );
  
  initial begin
    five_bit_in = 5'b10101;
    #100;
    five_bit_in = 5'b01011;
    #100;
    five_bit_in = 5'b01111;
    #100;
  end
endmodule
  
