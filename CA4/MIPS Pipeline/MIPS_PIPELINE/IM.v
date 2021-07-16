`include "defs.v"
module IM(
    input  [`LEN_ADR_MEM-1:0] adr,
    output [`LEN_INST-1:0] inst
);

    reg [`LEN_INST-1:0] InstSet [0:`SIZE_MEM-1];
    initial begin
        $readmemb("instructions.txt", InstSet);
    end
    assign inst = InstSet[adr];

endmodule
