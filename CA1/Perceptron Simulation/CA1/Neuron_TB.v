module Neuron_TB();

wire signed [13:0] w1,w2,bias;
wire ready;
reg start = 0, clk = 0 , rst = 0;
wire signed [15:0] out_rom;

Neuron UUT(start,clk,rst,ready,w1,w2,bias);

always #20 clk = ~clk;

// initial begin 
//         #1000 rst = 1;
//         #10000 rst = 0;
// end


initial begin
        #10; rst = 1;
        #50; rst = 0;
        #10; start = 1;
        #40; start = 0;
        #10000 $stop;
    end


endmodule


// module Neuron(input start, clk, rst, output ready, output signed [13:0] w1, w2, bias);


module TestNeuron_TB();

wire signed [13:0] w1,w2,bias;
wire ready, cout, error, flag;
reg start = 0, clk = 0 , rst = 0;
wire signed [15:0] out_rom;
wire signed [6:0] out_x1,out_x2;
wire signed [13:0] out_y; 
wire signed [1:0] out_t;
wire signed [13:0] out_mux_5;
wire signed [13:0] out_mux_2;
wire out_sel_w1_w2;
wire signed [1:0] out_inT;

NewNeuron UUT(start,clk,rst,ready,w1,w2,bias,cout,error,flag,out_rom,out_x1,out_x2,out_y,out_t,out_mux_2,out_mux_5,out_sel_w1_w2,out_inT);

always #20 clk = ~clk;

// initial begin 
//         #1000 rst = 1;
//         #10000 rst = 0;
// end


initial begin
        #10; rst = 1;
        #50; rst = 0;
        #10; start = 1;
        #40; start = 0;
        // #6000000 $stop;
        #5999399 $stop;
        // #10000000 $stop;
    end

endmodule