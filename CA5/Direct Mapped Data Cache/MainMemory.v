`include "defs.v"

module MEM(
    input write, read,
    input[`LEN_ADR-1:0] adr, 
    input [`LEN_DATA-1:0] data, 
    output reg ready,
    output reg [`LEN_DATA*4-1:0] out
);

    reg [`LEN_DATA-1:0] Memory [0:`SIZE_MEM-1];
    integer x;
    always @(write, read, adr, data) begin
        ready = 0;
        #100;
        if(read) begin
            $readmemb("datamemory.txt",Memory);
            x    = adr-adr%4;
            $display(x);
            out  = {Memory[x+3], Memory[x+2], Memory[x+1], Memory[x]};
            ready = 1;
            $display("%b",Memory[x+3]);
            $display("%b",Memory[x+2]);
            $display("%b",Memory[x+1]);
            $display("%b",Memory[x]);
        end
        else if(write) begin
            Memory[adr] = data; 
            $writememb("datamemory.txt",Memory);
        end
    end
    
endmodule




module TB_MEM();

    reg write, read;
    reg [`LEN_ADR-1:0] adr;
    reg [`LEN_DATA-1:0] data;
    wire ready;
    wire [`LEN_DATA*4-1:0] out;
    MEM UUT (
       write, read,
       adr, 
       data, 
       ready,
       out
    );



    initial begin
        adr = 1050;
        read = 1;
        #1000; $stop;
    end




endmodule