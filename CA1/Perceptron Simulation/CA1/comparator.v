module comparator  (input signed [13:0] x, input signed [1:0] y, output reg out);

// assign out = ~(x==y);


always @(x,y) begin
    
    if(x == 14'b00000000000000)begin
        if(y == 2'b00) out = 1'b0;
        else out = 1'b1;
    end
    else out = ~(x[13] == y[1]);

end

endmodule
