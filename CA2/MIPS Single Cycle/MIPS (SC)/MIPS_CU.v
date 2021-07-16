
module MIPS_CU (input [15:0] inst, input zero, output reg rf_write, alu_sel, alu_src, mem_read, mem_write,
               memtoreg, output reg [2:0] rf_wnd, op, output reg[1:0] pc_src);
               
  //rf_wnd = 3'b000;
  
  always @(inst)
  begin
    case(inst[15:12]) //opcode
      4'b0000: begin
        pc_src = 2'b10;
        rf_write = 1'b1;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b1;
        mem_write = 1'b0;
        memtoreg = 1'b0;
        op = 3'b000; end
      4'b0001: begin
        pc_src = 2'b10;
        rf_write = 1'b0;
        alu_sel = 1'b1;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b1;
        memtoreg = 1'b0;
        op = 3'b000; end
      4'b0010: begin
        pc_src = 2'b00;
        rf_write = 1'b0;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b0;
        op = 3'b000; end
      4'b0100: begin
        pc_src = 2'b10;
        rf_write = 1'b0;
        alu_sel = 1'b1;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b0;
        op = 3'b000; end
      4'b1000: begin
        if (inst[7:0] == 8'b10000000)  begin
          pc_src = 2'b10;
          rf_write = 1'b0;
          alu_sel = 1'b0;
          alu_src = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b0;
          op = 3'b000;
          rf_wnd = 3'b000; end
        else if (inst[7:0] == 8'b10000001)  begin
          pc_src = 2'b10;
          rf_write = 1'b0;
          alu_sel = 1'b0;
          alu_src = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b0;
          op = 3'b000;
          rf_wnd = 3'b010; end
        else if (inst[7:0] == 8'b10000010)  begin
          pc_src = 2'b10;
          rf_write = 1'b0;
          alu_sel = 1'b0;
          alu_src = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b0;
          op = 3'b000;
          rf_wnd = 3'b100; end
        else if (inst[7:0] == 8'b10000011)  begin
          pc_src = 2'b10;
          rf_write = 1'b0;
          alu_sel = 1'b0;
          alu_src = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b0;
          op = 3'b000;
          rf_wnd = 3'b110; end
        else if (inst[7:0] == 8'b00000001)  begin
          pc_src = 2'b10;
          rf_write = 1'b1;
          alu_sel = 1'b1;
          alu_src = 1'b1;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b1;
          op = 3'b001; end
        else begin
          pc_src = 2'b10;
          rf_write = 1'b1;
          alu_sel = 1'b1;
          alu_src = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          memtoreg = 1'b1;
          if (inst[7:0] == 8'b00000010) op = 3'b001;
          else if (inst[7:0] == 8'b00000100)  op = 3'b010;
          else if (inst[7:0] == 8'b00001000)  op = 3'b011;
          else if (inst[7:0] == 8'b00010000)  op = 3'b100;
          else if (inst[7:0] == 8'b00100000)  op = 3'b101;
          else if (inst[7:0] == 8'b01000000)  op = 3'b110; end 
        end
      4'b1100: begin
        pc_src = 2'b10;
        rf_write = 1'b1;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b1;
        op = 3'b001; end
      4'b1101: begin
        pc_src = 2'b10;
        rf_write = 1'b1;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b1;
        op = 3'b010; end
      4'b1110: begin
        pc_src = 2'b10;
        rf_write = 1'b1;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b1;
        op = 3'b011; end
      4'b1111: begin
        pc_src = 2'b10;
        rf_write = 1'b1;
        alu_sel = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        memtoreg = 1'b1;
        op = 3'b100; end
      default: rf_wnd = 3'b000;
    endcase
  end
endmodule

