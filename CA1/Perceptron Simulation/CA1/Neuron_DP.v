module Neuron_DP(input clk, rst, 
                 input ld_x1, ld_x2, ld_w1, ld_w2, ld_t, ld_alpha, ld_mult, ld_b, ld_y, ld_flag, ld_cnt,
                 input init0_w1, init0_w2, init0_b, init0_y, init0_flag,
                 input en_cnt,
                 input sel_x1_x2, sel_w1_w2,input[1:0] sel_t_x1_x2, input sel_alpha_mult, input[1:0] sel_b_w1_w2,input sel_b_mult,
                 output error, flag, co,
                 output signed [13:0]  out_w1, out_w2, out_bias,
                 output signed [15:0] out_rom, output signed [6:0] out_x1, out_x2,output signed [13:0] out_y, output signed [1:0] out_t,output signed [13:0] out_mux_2,output signed [13:0] out_mux_5,output signed [1:0] out_inT);



//----------------------------------------------------------------------------------------------------------------------------
//defining busssses for left registers
wire signed [15: 0]  obus_rom;
wire signed [6 : 0]  ibus_reg_x1, ibus_reg_x2, obus_reg_x1, obus_reg_x2;
wire signed [13: 0]  ibus_reg_w1, ibus_reg_w2, obus_reg_w1, obus_reg_w2;
wire signed [1 : 0]  ibus_reg_t, obus_reg_t;
wire signed [6 : 0]  ibus_reg_alpha, obus_reg_alpha;



//assinging 0.75 as a learning rate
assign ibus_reg_alpha = 7'b0001100;

register #(7) reg_alpha(.data(ibus_reg_alpha),.clk(clk),.ld(ld_alpha),.rst(rst),.out(obus_reg_alpha));

//ROM Splitting into three parts for x1,x2,t as inputs
assign ibus_reg_x1 = obus_rom[15:9];
assign ibus_reg_x2 = obus_rom[8:2];
assign ibus_reg_t  = obus_rom[1:0];

//connecting registers
register #(7)  reg_x1(.data(ibus_reg_x1), .clk(clk), .ld(ld_x1), .rst(rst), .out(obus_reg_x1));
register #(7)  reg_x2(.data(ibus_reg_x2), .clk(clk), .ld(ld_x2), .rst(rst), .out(obus_reg_x2));
register #(2)  reg_t (.data(ibus_reg_t), .clk(clk), .ld(ld_t), .rst(rst), .out(obus_reg_t));
register #(14) reg_w1(.data(ibus_reg_w1), .clk(clk), .ld(ld_w1), .rst(rst), .init0(init0_w1),.out(obus_reg_w1));
register #(14) reg_w2(.data(ibus_reg_w2), .clk(clk), .ld(ld_w2), .rst(rst), .init0(init0_w2),.out(obus_reg_w2));



wire signed [6 : 0]  obus_mux_1p;
wire signed [13: 0]  obus_mux_1;
Mux2 #(7) mux_1(.x(obus_reg_x1),.y(obus_reg_x2),.sel(sel_x1_x2),.out(obus_mux_1p));
signExtend #(7,3,4) extend1(.x(obus_mux_1p),.out(obus_mux_1));


wire signed [13: 0] obus_mux_2;
Mux2 #(14) mux_2(.x(obus_reg_w1),.y(obus_reg_w2),.sel(sel_w1_w2),.out(obus_mux_2));


wire signed [6:0]  obus_reg_t_ex;
wire signed [6:0]  obus_mux_3;
signExtend #(2,1,4) extend2(.x(obus_reg_t),.out(obus_reg_t_ex));
Mux3 #(7) mux_3(.x(obus_reg_t_ex),.y(obus_reg_x1),.z(obus_reg_x2),.sel(sel_t_x1_x2),.out(obus_mux_3));


wire signed [13:0] obus_mult_2;
wire signed [13:0] obus_reg_mult;
register #(14) reg_mult(.data(obus_mult_2),.clk(clk),.ld(ld_mult),.rst(rst),.out(obus_reg_mult));

wire signed [6:0] obus_reg_mult_ex;
assign obus_reg_mult_ex = obus_reg_mult[10:4];

wire signed [6:0] obus_mux_4;
Mux2 #(7) mux_4(.x(obus_reg_alpha),.y(obus_reg_mult_ex),.sel(sel_alpha_mult),.out(obus_mux_4));

multiplier #(7) multiplier_2 (.x(obus_mux_3),.y(obus_mux_4),.out(obus_mult_2));

wire signed [27:0] obus_mult_1;
wire signed [13:0] obus_mult_1_ex;
assign obus_mult_1_ex = obus_mult_1[21:8];

multiplier #(14) multiplier_1 (.x(obus_mux_2),.y(obus_mux_1),.out(obus_mult_1));

wire signed [13:0] obus_reg_b;
wire signed [13:0] ibus_reg_b;

register #(14) reg_b (.data(ibus_reg_b),.clk(clk),.ld(ld_b),.rst(rst),.init0(init0_b),.out(obus_reg_b));


wire signed [13:0] obus_mux_5;
Mux2 #(14) mux_5(.x(obus_reg_b),.y(obus_mult_1_ex),.sel(sel_b_mult),.out(obus_mux_5));


wire signed [13:0] obus_mux_6;
Mux3 #(14) mux_6(.x(obus_reg_b),.y(obus_reg_w1),.z(obus_reg_w2),.sel(sel_b_w1_w2),.out(obus_mux_6));

adder #(14) adder_2(.x(obus_mux_6),.y(obus_reg_mult),.out(ibus_reg_b));
//###############################################################################################################################################################
assign ibus_reg_w1 = ibus_reg_b;
assign ibus_reg_w2 = ibus_reg_b;
//###############################################################################################################################################################

wire signed [13:0] obus_add_1;
wire signed [13:0] obus_reg_y;
register #(14) reg_y(.data(obus_add_1),.clk(clk),.ld(ld_y),.rst(rst),.init0(init0_y),.out(obus_reg_y));
adder #(14) adder_1(.x(obus_reg_y),.y(obus_mux_5),.out(obus_add_1));


    // xor xor_1(error,obus_reg_y[13],obus_reg_t[1]);
comparator comp(.x(obus_reg_y),.y(obus_reg_t),.out(error));

register #(1) reg_flag(.data(error),.clk(clk),.ld(ld_flag),.init0(init0_flag),.rst(rst),.out(flag));


//connecting ROM
wire[7:0] obus_addres;
cnt counter_1(.clk(clk),.rst(rst),.enable(en_cnt),.load(ld_cnt),.out(obus_addres),.cout(co));
ROM rom_1(.address(obus_addres),.data(obus_rom));
//------------------------------------------------------------------------------------------------------------------

assign out_w1 = obus_reg_w1;
assign out_w2 = obus_reg_w2;
assign out_bias = obus_reg_b;


assign out_rom = obus_rom;
assign out_x1 = obus_reg_x1;
assign out_x2 = obus_reg_x2;
assign out_y = obus_reg_y;
assign out_t = obus_reg_t;
assign out_mux_5 = obus_mux_5;
assign out_mux_2 = obus_mux_2;
assign out_inT = ibus_reg_t;
endmodule