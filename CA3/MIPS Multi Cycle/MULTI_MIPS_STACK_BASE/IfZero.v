module IfZero  #(parameter n) ( input[n-1:0] data, output reg out);

    always @(data) begin
        if (data == 0)  out = 1;
        else out = 0;
    end
   
endmodule

module TB_IfZero();

    reg[7:0] data;
    wire out;
    IfZero #(8) UUT(data, out);
    initial begin
        data=22;
        #23
        data=0;
        #31
        data=12;
        #30 data=62;
        #12
        data = 0;
        #20 $stop;
    end


endmodule