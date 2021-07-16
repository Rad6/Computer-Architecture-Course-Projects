module MIPS_DP(input clk, rst, input[1:0] sig_pc_src,
               input sig_rf_write, sig_alu_src, sig_alu_sel, sig_mem_write, sig_mem_read, sig_memtoreg,
               input[2:0] sig_rf_wnd, sig_op,
               output[15:0] inst, ans,
               output zero);    

    //MEM TO DATAPATH:
    wire[9:0] _mem_adr;
    wire[15:0] _mem_data;
    wire[15:0] _mem_out;
    wire _mem_sig_write, _mem_sig_read;
    MEM _mem(.adr(_mem_adr),.data(_mem_data),.out(_mem_out),
             .sig_write(_mem_sig_write),.sig_read(_mem_sig_read));

    //IM TO DATAPATH
    wire[9:0] _im_adr;
    wire[15:0] _im_inst;
    IM _im(.adr(_im_adr),.inst(_im_inst));

    //RF TO DATAPATH
    wire[1:0] _rf_in1, _rf_in2, _rf_wrR;
    wire[15:0] _rf_data, _rf_out1, _rf_out2;
    wire[2:0] _rf_sig_wnd;
    wire _rf_sig_write;
    RF _rf(.in1(_rf_int1),.in2(_rf_in2),.wrR(_rf_wrR),.data(_rf_data),
           .sig_write(_rf_sig_write),.sig_wnd(_rf_sig_wnd),
           .out1(_rf_out1),.out2(_rf_out2));
 
    //PC TO DATAPAC
    wire[9:0] _pc_in, _pc_out;
    PC _pc(.in(_pc_in),.clk(clk),.rst(rst),.out(_pc_out));

    //ALU TO DATAPATH
    wire[15:0] _alu_A, _alu_B, _alu_out;
    wire[2:0] _alu_sig_op;
    wire _alu_zero;
    ALU _alu(.A(_alu_A),.B(_alu_B),.sig_op(_alu_sig_op),
             .zero(_alu_zero),.out(_alu_out));

    //ADDER TO DATAPATH FOR PC
    wire[9:0] _adder_x, _adder_y, _adder_out;
    adder #(10) _adder(.x(_adder_x),.y(_adder_y),.out(_adder_out));

    //MUX3_0 TO DATAPATH
    wire[1:0] _mux3_0_sel;
    wire[9:0] _mux3_0_x, _mux3_0_y, _mux3_0_z, _mux3_0_out;
    Mux3 #(10) _mux3_0(.x(_mux3_0_x),.y(_mux3_0_y),.z(_mux3_0_z),.sel(_mux3_0_sel),.out(_mux3_0_out));

    //MUX2_0 TO DATAPATH
    wire _mux2_0_sel;
    wire[15:0] _mux2_0_x, _mux2_0_y, _mux2_0_out;
    Mux2 #(16) _mux2_0(.x(_mux2_0_x),.y(_mux2_0_y),.sel(_mux2_0_sel),.out(_mux2_0_out));

    //MUX2_1 TO DATAPATH
    wire _mux2_1_sel;
    wire[15:0] _mux2_1_x, _mux2_1_y, _mux2_1_out;
    Mux2 #(16) _mux2_1(.x(_mux2_1_x),.y(_mux2_1_y),.sel(_mux2_1_sel),.out(_mux2_1_out));

    //MUX2_2 TO DATAPATH
    wire _mux2_2_sel;
    wire[15:0] _mux2_2_x, _mux2_2_y, _mux2_2_out;
    Mux2 #(16) _mux2_2(.x(_mux2_2_x),.y(_mux2_2_y),.sel(_mux2_2_sel),.out(_mux2_2_out));


    //ASSIGNINNINIGNING
    assign _pc_in = _mux3_0_out;
    assign _im_adr=_pc_out;
    assign _adder_x = 1'b1;
    assign _adder_y = _pc_out;
    assign _mux3_0_z = _adder_out;
    assign _mux3_0_y = {_pc_out[9:8],_im_inst[7:0]};
    assign _mux3_0_x = _im_inst[9:0];
    assign _rf_in1 = _im_inst[11:10];
    assign _rf_in2 = _im_inst[9:8];
    assign _rf_wrR = _im_inst[11:10];
    assign _rf_data = _mux2_2_out;
    assign _rf_out1 = _mux2_0_y;
    assign _mux2_x  = {8'b00000000,_im_inst[7:0]};
    assign _rf_out2 = _mux2_1_x;
    assign _mux2_1_y = 16'b0;
    assign _alu_A = _mux2_0_out;
    assign _alu_B = _mux2_1_out;
    assign _mem_adr = _im_inst[9:0];
    assign _mem_data = _mux2_0_out;
    assign _mux2_2_x = _mem_out;
    assign _mux2_2_y = _alu_out;


    //ASSISGINGINGINGI CONTROLL SIGNALS
    assign _mux3_0_sel = sig_pc_src;
    assign _mux2_0_sel = sig_alu_sel;
    assign _mux2_1_sel = sig_alu_src;
    assign _mux2_2_sel = sig_memtoreg;
    assign _rf_sig_write = sig_rf_write;
    assign _rf_sig_wnd = sig_rf_wnd;
    assign _alu_sig_op = sig_op;
    assign _mem_sig_write = sig_mem_write;
    assign _mem_sig_read = sig_mem_read;

    //ASSIGN ZERO
    assign zero = _alu_zero;
    assign inst = _im_inst;


       //
       assign ans = _rf_out1;

endmodule
