module IM(
    input  [31:0] adr,
    output [31:0] inst
);

    wire [9:0] new_adr;
    assign new_adr = {adr[9:0]};
    reg [31:0] InstSet [1023:0];
    initial begin
      $readmemb("instructions.txt", InstSet);
    end
    assign inst = InstSet[new_adr];

endmodule
