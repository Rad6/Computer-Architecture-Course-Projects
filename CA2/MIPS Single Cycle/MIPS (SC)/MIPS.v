module MIPS(input clk, rst, output[15:0] ans);

    wire rf_write, alu_sel, alu_src, mem_read, mem_write, memtoreg;
    wire[2:0] rf_wnd, op; wire[1:0] pc_src;
    wire[15:0] inst; wire zero;

    MIPS_DP dp(.clk(clk), .rst(rst), .sig_pc_src(pc_src),
               .sig_rf_write(rf_write), .sig_alu_src(alu_src), .sig_alu_sel(alu_sel),
               .sig_mem_write(mem_write), .sig_mem_read(mem_read), .sig_memtoreg(memtoreg),
               .sig_rf_wnd(rf_wnd), .sig_op(op),
               .inst(inst), .ans(ans),
               .zero(zero));

    MIPS_CU cu(.inst(inst), .zero(zero),
               .rf_write(rf_write), .alu_sel(alu_sel), .alu_src(alu_src),
               .mem_read(mem_read), .mem_write(mem_write),
               .memtoreg(memtoreg), .rf_wnd(rf_wnd), .op(op), .pc_src(pc_src));

endmodule