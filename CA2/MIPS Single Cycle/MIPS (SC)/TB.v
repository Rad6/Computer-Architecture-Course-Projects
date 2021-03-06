module TB();
    reg rst = 1'b0, clk = 1'b0;
    wire[15:0] ans;

    MIPS UUT(clk, rst, ans);

    initial begin
        #5; rst = 1'b1;
        #5; rst = 1'b0;
        #1000; $stop;
    end
    
    always #100 clk = ~clk;

endmodule