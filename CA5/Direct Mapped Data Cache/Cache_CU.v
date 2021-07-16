module Cach_CU(
    input clk, rst,
    input hit, mem_ready,
    output reg read, done, write
);


    parameter IDLE = 0, HITING = 1, WAITING = 2, MISING = 3;
    reg [1:0] ns, ps;
    always @(posedge clk, posedge rst) begin
        if(rst) ps <= IDLE;
        else ps <= ns;
    end


    always @(hit, mem_ready, ps) begin: transition
        ns = IDLE;
        case(ps)
            IDLE    : ns = hit ? HITING : WAITING;
            HITING  : ns = IDLE;
            WAITING : ns = mem_ready ? MISING: WAITING;
            MISING  : ns = IDLE;
            default : begin 
                ns = IDLE;
                $display("XXX Transition Controller Default XXX");
            end
        endcase
    end


    always @(hit, done, ps) begin: outputing
        {read, done, write} = 0;
        case(ps)
            HITING  : done = 1;
            WAITING : read = 1;
            MISING  : begin write = 1; done = 1; end
            default : begin 
               {read, done, write} = 0;
              //  $display("XXX Outputing Controller Default XXX");
            end
        endcase
    end




endmodule

