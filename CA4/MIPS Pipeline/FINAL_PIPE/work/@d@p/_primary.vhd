library verilog;
use verilog.vl_types.all;
entity DP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ALUSrc          : in     vl_logic;
        RegDst          : in     vl_logic;
        alu_op          : in     vl_logic_vector(2 downto 0);
        MemWrite        : in     vl_logic;
        MemRead         : in     vl_logic;
        RegWrite        : in     vl_logic;
        MemToReg        : in     vl_logic;
        inst            : out    vl_logic_vector(31 downto 0)
    );
end DP;
