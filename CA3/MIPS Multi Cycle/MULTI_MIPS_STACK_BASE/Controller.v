// Controller of MULTI MIPS STACK BASE
module Controller(input clk, rst, input[2:0] inst,
                  output reg PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite,
                  MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS,
                  output reg[1:0]  AluOp);

    parameter[3:0] IF = 4'b0000 , ID = 4'b0001, JMP1 = 4'b0010, JZ1 = 4'b0011,
                   PUSH1 = 4'b0100, PUSH2 = 4'b0101, O1 = 4'b0110, O2 = 4'b0111,
                   POP1 = 4'b1000, NOT1 = 4'b1001, PUSHG = 4'b1010, LOGIC1 = 4'b1011,
                   LOGIC2 = 4'b1100, LOGIC3 = 4'b1101;

    parameter[2:0] _push = 3'b100, _pop = 3'b101, _jmp = 3'b110, _jz = 3'b111, 
                   _add = 3'b000, _sub = 3'b001, _and = 3'b010, _not = 3'b011;

    parameter[1:0] alu_sub = 2'b01, alu_add = 2'b00, alu_and = 2'b10, alu_not = 2'b11;
    
    reg[3:0] ns, ps = IF;
    always@(posedge clk, posedge rst) begin
        if(rst) ps <= IF;
        else ps <= ns;
    end

    always@(*) begin:transition
        //ns = IF;
        case(ps)
            IF     : ns = ID;
            ID     : begin 
                       if (inst == _push)     ns = PUSH1;
                       else if (inst == _jmp) ns = JMP1;
                       else if (inst == _jz)  ns = JZ1;
                       else ns = O1;
                     end
            JMP1   : ns = IF;
            JZ1    : ns = IF;
            PUSH1  : ns = PUSH2;
            PUSH2  : ns = IF;
            O1     : ns = O2;
            O2     : begin
                        if (inst == _not) ns = NOT1;
                        else if (inst == _pop) ns = POP1;
                        else ns = LOGIC1;
                     end
            POP1   : ns = IF;
            NOT1   : ns = PUSHG;
            PUSHG  : ns = IF;
            LOGIC1 : ns = LOGIC2;
            LOGIC2 : ns = LOGIC3;
            LOGIC3 : ns = PUSHG;
            default: ns =  IF;
        endcase
    end

    always@(*) begin:outputing
        {PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite} = 6'b0;
        {MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS} = 9'b0;
        AluOp = alu_add;
        case(ps)
            IF     : begin
                        PorI = 0;
                        SrcA = 1;
                        SrcB = 1;
                        AluOp = alu_add;
                        PcSrc = 0;
                        PcWrite = 1;
                        MemRead = 1;
                        IRWrite = 1;
                       // $display("IF");
                     end
            ID     : begin 
                       toS = 1;
                       //$display("ID");
                     end
            JMP1   : begin 
                       PcSrc = 1;
                       PcWrite = 1;
                       //$display("JMP1");
                     end
            JZ1    : begin 
                       PcWriteC = 1;
                       PcSrc = 1;
                      // $display("JZ1");
                     end
            PUSH1  : begin 
                       PorI = 1;
                       MemRead = 1;
                       //$display("PUSH1");
                     end
            PUSH2  : begin 
                       MtoS = 1;
                       Push = 1;
                       //$display("PUSH2");
                     end
            O1     : begin 
                       Pop = 1;
                       //$display("O1");
                     end
            O2     : begin
                       LdA = 1;
                       //$display("O2");
                     end
            POP1   : begin 
                       PorI = 1;
                       MemWrite = 1;
                       //$display("POP1");
                     end
            NOT1   : begin 
                       AluOp = alu_not;
                       //$display("NOT1");
                     end
            PUSHG  : begin 
                       Push = 1;
                       //$display("PUSHG");
                     end
            LOGIC1 : begin 
                       Pop = 1;
                       //$display("LOGIC1");
                     end
            LOGIC2 : begin 
                       LdB = 1;
                       //$display("LOGIC2");
                     end
            LOGIC3 : begin
                       case(inst)
                            _add : AluOp = alu_add;
                            _sub : AluOp = alu_sub;
                            _and : AluOp = alu_and;
                            default : begin
                                        AluOp = alu_add;
                                      end
                       endcase
                       //$display("LOGIC3");
                     end
            default: begin
                        {PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite} = 6'b0;
                        {MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS} = 9'b0;
                        AluOp = alu_add;
                        $display("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&DEAFAUL");
                     end
        endcase
    end

endmodule

module TB_Controller();

  parameter[2:0] _push = 3'b100, _pop = 3'b101, _jmp = 3'b110, _jz = 3'b111, 
                   _add = 3'b000, _sub = 3'b001, _and = 3'b010, _not = 3'b011;

  reg clk = 0, rst = 0;
  reg[2:0] inst;
  wire PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite, MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS;
  wire[1:0] AluOp;

  always #23 clk = ~clk;

  Controller UUT(clk, rst, inst,
                    PcWrite, PcWriteC, PcSrc, PorI, MemRead, IRWrite,
                    MemWrite, MtoS, LdA, LdB, SrcA, SrcB, Push, Pop, toS,
                    AluOp);


  initial begin
    rst = 1;
    #5;
    rst = 0;
    //inst = _pop;
    //#5000 $stop;
    
    inst = _pop;
    #500

    inst = _push;
    #500

    inst = _add;
    #500

    inst = _sub;
    #500

    inst = _jmp;
    #500

    inst = _add;
    #500 $stop;

  end

endmodule