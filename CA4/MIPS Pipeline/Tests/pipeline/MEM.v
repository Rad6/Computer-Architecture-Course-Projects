`include "defs.v"

module MEM(input write, read,
           input[`LEN_DATA-1:0] adr, 
           input [`LEN_DATA-1:0] data, 
           output reg [`LEN_DATA-1:0] out);

    reg [`LEN_DATA-1:0] Memory [0:`SIZE_MEM-1];

    always@(write, read, adr, data)begin
        if(read) begin
            $readmemb("datamemory.txt",Memory);
            out = Memory[adr];
        end
        else if(write) begin
            Memory[adr] = data;
            $writememb("datamemory.txt",Memory);
        end
    end
    
endmodule