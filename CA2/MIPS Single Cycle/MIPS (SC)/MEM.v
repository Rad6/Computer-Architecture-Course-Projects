// module MEM(input[9:0] adr, input [15:0] data, input sig_write, sig_read, output reg [15:0] out);

//     reg [15:0] Memory [0:999];
    
//     always@(sig_write, sig_read, adr, data)begin
//         if(sig_read) out = Memory[adr];
//         else if(sig_write) Memory[adr] = data;
//     end
    
// endmodule

module MEM(input[9:0] adr, input [15:0] data, input sig_write, sig_read, output reg [15:0] out);

    reg [15:0] Memory [0:999];

    always@(sig_write, sig_read, adr, data)begin

        if(sig_read) 
    begin
    $readmemb("datamemory.txt",Memory);
    out = Memory[adr];
    end
        else if(sig_write)
    begin
     Memory[adr] = data;
    $writememb("datamemory.txt",Memory);
    end
    end
    
endmodule