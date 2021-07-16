
module NewNeuron(input start, clk, rst, output ready, output signed [13:0] w1, w2, bias, output cout1, error1, flag1, output signed [15:0] out_rom1 , output signed [6:0] out_x11,out_x21,output signed [13:0] out_y1, output signed [1:0] out_t1,output signed [13:0] out_mux_2 ,output signed [13:0] out_mux_5
                ,output out_sel_w1_w2,output signed [1:0] out_inT);

wire ldalpha, initB0, initW1_0, initW2_0, initflag0, ldcnt, ldx1, ldx2, ldt, inity0;
wire selx1_x2, selw1_w2, sel_b_mult, ldy, cnt_en, ldflag, selalpha_mult, ldmult;
wire [1:0] selt_x1_x2, selB_w1_w2;
wire ldw1, ldw2, ldB;
wire error,cout,flag;

assign cout1 = cout;
assign error1 = error;
assign flag1 = flag;

wire signed [15:0] out_rom;
assign out_rom1 = out_rom;

wire signed [6:0] out_x1,out_x2;
assign out_x11 = out_x1;
assign out_x21 = out_x2;


wire signed [13:0] out_y; 
wire signed [1:0] out_t;
assign out_y1 = out_y;
assign out_t1 = out_t;

assign out_sel_w1_w2 = selw1_w2;

CU controller(clk, rst, start, error, cout, flag,
              ready, ldalpha, initB0, initW1_0, initW2_0, initflag0, ldcnt, ldx1, ldx2, ldt, inity0,
              selx1_x2, selw1_w2, sel_b_mult, ldy, cnt_en, ldflag, selt_x1_x2, selalpha_mult, ldmult,
              selB_w1_w2, ldw1, ldw2, ldB);


Neuron_DP datapath(clk, rst,
                    ldx1,ldx2,ldw1,ldw2,ldt,ldalpha,ldmult,ldB,ldy,ldflag,ldcnt,
                    initW1_0,initW2_0,initB0,inity0,initflag0,
                    cnt_en,
                    selx1_x2,selw1_w2,selt_x1_x2,selalpha_mult,selB_w1_w2,sel_b_mult,
                    error,flag,cout,
                    w1,w2,bias,
                    out_rom,out_x1,out_x2,out_y,out_t,out_mux_2,out_mux_5 , out_inT);

endmodule
