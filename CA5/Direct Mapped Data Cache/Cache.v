`include "defs.v"

module Cache(
    input clk, rst, write,
    input [`LEN_DATA*4-1:0] i_data,
    input [`LEN_ADR-1:0] adr,
    output  hit,
    output reg [`LEN_DATA-1:0] o_data
);

    reg [`LEN_CACHE_DATA-1:0] Memory [0:`SIZE_CACHE-1];
    integer i;
    always @ (posedge clk, posedge rst) begin : main_cache_logic
        if(rst) begin
            for(i=0; i < `SIZE_CACHE; i=i+1) begin
                Memory[i] <= 0;
            end
            o_data <= 0;
        end 

        else begin 
            if(hit) begin
                case(adr[1:0])
                    3: o_data <= Memory[adr[11:2]][31 : 0];
                    2: o_data <= Memory[adr[11:2]][63 :32];
                    1: o_data <= Memory[adr[11:2]][95 :64];
                    0: o_data <= Memory[adr[11:2]][127:96];
                    default : o_data <= 1'bz;
                endcase
            end
            else if (write) begin
                if(hit == 0)begin
                case(adr[1:0])
                   3: o_data <= i_data[127:96];
                   2: o_data <= i_data[95 :64];
                   1: o_data <= i_data[63 :32];
                   0: o_data <= i_data[31 : 0];
                   default : o_data <= 1'bz;
                endcase
                Memory[adr[11:2]][31 : 0] <= i_data[127:96];
                Memory[adr[11:2]][63 :32] <= i_data[95 :64];
                Memory[adr[11:2]][95 :64] <= i_data[63 :32];
                Memory[adr[11:2]][127:96] <= i_data[31 : 0];
                Memory[adr[11:2]][131] <= 1;
              end
                $writememb("Test.txt",Memory);
            end
        end
    end

    assign hit = ((Memory[adr[11:2]][131] == 1) && (Memory[adr[11:2]][130:128] == adr[14:12]));

endmodule


module cache_tb();
  
  reg clk = 0, rst = 0, write = 0;
  reg [127:0] i_data;
  reg [`LEN_ADR-1:0] adr;
  wire hit;
  wire [`LEN_DATA-1:0] o_data;
  
  
  Cache UUT(
    clk, rst, write,
    i_data,
    adr,
    hit,
    o_data
  );
  
  always #20 clk = ~clk;
  
  initial begin
    rst = 1;
    #10;
    rst = 0;
    write = 1;
    i_data = 128'd56;
    adr = 15'd10; // 000000000001010
    #100;
    i_data = 128'd56;
    adr = 15'd10; // 000000000001010
    #100;
  end
endmodule
    

