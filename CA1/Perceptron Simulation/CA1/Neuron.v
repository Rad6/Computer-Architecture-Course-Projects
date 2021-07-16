module Neuron(input start, clk, rst, output ready, output signed [13:0] w1, w2, bias);

wire ldalpha, initB0, initW1_0, initW2_0, initflag0, ldcnt, ldx1, ldx2, ldt, inity0;
wire selx1_x2, selw1_w2, sel_b_mult, ldy, cnt_en, ldflag, selt_x1_x2, selalpha_mult, ldmult;
wire selB_w1_w2, ldw1, ldw2, ldB;
wire error,cout,flag;

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
                    w1,w2,bias);

endmodule
