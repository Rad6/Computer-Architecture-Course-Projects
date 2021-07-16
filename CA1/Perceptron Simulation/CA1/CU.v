
module CU(input clk, rst, start, error, cout, flag, 
          output reg ready, ldalpha, initB0, initW1_0, initW2_0, initflag0, ldcnt, ldx1, ldx2, ldt, inity0,
          output reg selx1_x2, selw1_w2, sel_b_mult, ldy, cnt_en, ldflag,output reg[1:0] selt_x1_x2, output reg selalpha_mult, ldmult,
          output reg[1:0] selB_w1_w2,output reg ldw1, ldw2, ldB);


    parameter IDLE = 4'b0000 , LOADING = 4'b0001, LOAD_CNT = 4'b0010, LOAD_DATA = 4'b0011, SEL1 = 4'b0100;
    parameter SEL2 = 4'b0101, ADD_B_1 = 4'b0110, CLK1 = 4'b0111, X1_ALPHA = 4'b1000, X1_ALPHA_T = 4'b1001;
    parameter ADD_W1 = 4'b1010, X2_ALPHA = 4'b1011, X2_ALPHA_T = 4'b1100, ADD_W2 = 4'b1101, ALPHA_T = 4'b1110, ADD_B_2 = 4'b1111;
    reg[3:0] ns, ps;


    always@(posedge clk, posedge rst) begin
        if(rst) ps <= IDLE;
        else ps <= ns;
    end

    always@(start, cout, error, flag, ps) begin //transition
        ns = IDLE;
        case(ps)
          
          IDLE      : ns = start  ?  LOADING  :  IDLE;
          LOADING   : ns = start  ?  LOADING  : LOAD_CNT;
          LOAD_CNT  : ns = LOAD_DATA;
          LOAD_DATA : ns = SEL1;
          SEL1      : ns = SEL2;
          SEL2      : ns = ADD_B_1;
          ADD_B_1   : ns = CLK1;
          CLK1      : begin
            // if ( cout && ~flag ) ns = IDLE;
            // else if ( ~cout && ~error ) ns = LOAD_DATA;
            // else if ( error ) ns = X1_ALPHA;
            // else if (cout && flag) ns = LOAD_CNT;

            if ( (cout == 1'b1) && (flag == 1'b0) ) ns = IDLE;
            else if ( (cout== 1'b0) && (error == 1'b0) ) ns = LOAD_DATA;
            else if ( error == 1'b1 ) ns = X1_ALPHA;
            else if ((cout == 1'b1) && (flag == 1'b1) ) ns = LOAD_CNT;
            else $display("JJJJJJJJJJJJJ");
            end
          X1_ALPHA  : ns = X1_ALPHA_T;
          X1_ALPHA_T: ns = ADD_W1;
          ADD_W1    : ns = X2_ALPHA;
          X2_ALPHA  : ns = X2_ALPHA_T;
          X2_ALPHA_T: ns = ADD_W2;
          ADD_W2    : ns = ALPHA_T;
          ALPHA_T   : ns = ADD_B_2;
          ADD_B_2   : ns = cout   ? LOAD_CNT : LOAD_DATA;
          default   : ns = IDLE;
              
        endcase
    end

    always@(start, cout, error, flag, ps) begin //outputing
    
        // {ready, ldalpha, initB0, initW1_0, initW2_0, initflag0, ldcnt, ldx1, ldx2, ldt, inity0} = 11'b0;
        // {selx1_x2, selw1_w2, sel_b_mult, ldy, cnt_en, ldflag, selalpha_mult, ldmult, ldw1, ldw2, ldB} = 11'b0;
        // selt_x1_x2 = 2'b0; selB_w1_w2 = 2'b0;
        
        // case(ps)
        //   IDLE      : begin  ready = 1'b1; $display("IDLE"); end
        //   LOADING   : begin {ldalpha, initB0, initW1_0, initW2_0, initflag0} = 5'b1; $display("loading"); end
        //   LOAD_CNT  : begin {ldcnt, initflag0} = 2'b1; $display("load_cnt"); end
        //   LOAD_DATA : begin {ldx1, ldx2, ldt, inity0} = 4'b1; $display("load_data"); end
        //   SEL1      : begin {sel_b_mult, ldy, cnt_en} = 3'b1;  $display("sel1"); end
        //   SEL2      : begin {selx1_x2, selw1_w2, sel_b_mult, ldy} = 4'b1;  $display("sel2"); end 
        //   ADD_B_1   : begin ldy = 1'b1;  $display("add_B_1"); end
        //   CLK1      : begin $display("CLK"); end
        //   X1_ALPHA  : begin
        //     selt_x1_x2 = 2'b01;
        //     {ldflag, ldmult} = 2'b1; $display("x1_alpha");end
        //   X1_ALPHA_T: begin {selalpha_mult, ldmult} = 2'b1; $display("x1_aplpha_t"); end
        //   ADD_W1    : begin
        //   selB_w1_w2 = 2'b01; ldw1 = 1'b1; $display("add_w1"); end
        //   X2_ALPHA  : begin 
        //     selt_x1_x2 = 2'b10; ldmult = 1'b1; $display("x2_alpha"); end
        //   X2_ALPHA_T: begin {selalpha_mult, ldmult} = 2'b1; $display("x2_alpha_t"); end
        //   ADD_W2    : begin
        //     selB_w1_w2 = 2'b10; ldw2 = 1'b1; $display("add_w2"); end
        //   ALPHA_T   : begin ldmult = 1'b1; $display("alpha_t"); end
        //   ADD_B_2   : begin ldB = 1'b1; $display("add_b_2"); end
        //   default   : $display("shitttttt"); 
        // endcase



        ready= 1'b0; ldalpha= 1'b0; initB0= 1'b0; initW1_0= 1'b0; initW2_0= 1'b0; initflag0= 1'b0; ldcnt= 1'b0; ldx1= 1'b0; ldx2= 1'b0; ldt= 1'b0; inity0 = 1'b0;
        selx1_x2= 1'b0; selw1_w2= 1'b0; sel_b_mult= 1'b0; ldy= 1'b0; cnt_en= 1'b0; ldflag= 1'b0; selalpha_mult= 1'b0; ldmult= 1'b0; ldw1= 1'b0; ldw2= 1'b0; ldB= 1'b0;
        
        case(ps)
          IDLE      : begin  ready = 1'b1; $display("IDLE"); end
          LOADING   : begin  ldalpha= 1'b1; initB0= 1'b1; initW1_0=1'b1; initW2_0= 1'b1; initflag0= 1'b1; $display("loading"); end
          LOAD_CNT  : begin  ldcnt= 1'b1; initflag0= 1'b1; $display("load_cnt"); end
          LOAD_DATA : begin  ldx1= 1'b1; ldx2= 1'b1; ldt= 1'b1; inity0= 1'b1; $display("load_data"); end
          SEL1      : begin  sel_b_mult= 1'b1; ldy= 1'b1; cnt_en= 1'b1;  $display("sel1"); end
          SEL2      : begin  selx1_x2= 1'b1; selw1_w2= 1'b1; sel_b_mult= 1'b1; ldy= 1'b1;  $display("sel2"); end 
          ADD_B_1   : begin  ldy = 1'b1;  $display("add_B_1"); end
          CLK1      : begin $display("CLK"); end
          X1_ALPHA  : begin
            selt_x1_x2 = 2'b01;
            ldflag= 1'b1; ldmult= 1'b1; $display("x1_alpha");end
          X1_ALPHA_T: begin selalpha_mult= 1'b1; ldmult= 1'b1; $display("x1_aplpha_t"); end
          ADD_W1    : begin
          selB_w1_w2 = 2'b01; ldw1 = 1'b1; $display("add_w1"); end
          X2_ALPHA  : begin 
            selt_x1_x2 = 2'b10; ldmult = 1'b1; $display("x2_alpha"); end
          X2_ALPHA_T: begin  selalpha_mult= 1'b1; ldmult= 1'b1; $display("x2_alpha_t"); end
          ADD_W2    : begin
            selB_w1_w2 = 2'b10; ldw2 = 1'b1; $display("add_w2"); end
          ALPHA_T   : begin ldmult = 1'b1; $display("alpha_t"); end
          ADD_B_2   : begin ldB = 1'b1; $display("add_b_2"); end
          default   : $display("Oops$$$$$$$$$$$$$$$$$$$$$");
        endcase
    end

endmodule
