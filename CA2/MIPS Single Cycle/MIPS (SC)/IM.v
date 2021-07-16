module IM(input[9:0] adr, output [15:0] inst);

    reg [15:0] InstSet [0:999];
    initial begin
        $readmemb("instructions.txt", InstSet);
    end
    assign inst = InstSet[adr];

endmodule
