library verilog;
use verilog.vl_types.all;
entity Control is
    port(
        inst            : in     vl_logic_vector(31 downto 0);
        ALUSrc          : out    vl_logic;
        RegDst          : out    vl_logic;
        alu_op          : out    vl_logic_vector(2 downto 0);
        PCSrc           : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemToReg        : out    vl_logic
    );
end Control;
