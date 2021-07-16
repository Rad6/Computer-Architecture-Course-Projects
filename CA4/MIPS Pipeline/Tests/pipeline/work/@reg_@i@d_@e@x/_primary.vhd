library verilog;
use verilog.vl_types.all;
entity Reg_ID_EX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        i_ALUSrc        : in     vl_logic;
        i_ALUop         : in     vl_logic_vector(2 downto 0);
        i_RegDst        : in     vl_logic;
        i_MemRead       : in     vl_logic;
        i_MemWrite      : in     vl_logic;
        i_RegWrite      : in     vl_logic;
        i_MemToReg      : in     vl_logic;
        i_data1         : in     vl_logic_vector(31 downto 0);
        i_data2         : in     vl_logic_vector(31 downto 0);
        i_imm           : in     vl_logic_vector(31 downto 0);
        i_rs            : in     vl_logic_vector(4 downto 0);
        i_rt            : in     vl_logic_vector(4 downto 0);
        i_rd            : in     vl_logic_vector(4 downto 0);
        o_ALUSrc        : out    vl_logic;
        o_ALUop         : out    vl_logic_vector(2 downto 0);
        o_RegDst        : out    vl_logic;
        o_MemRead       : out    vl_logic;
        o_MemWrite      : out    vl_logic;
        o_RegWrite      : out    vl_logic;
        o_MemToReg      : out    vl_logic;
        o_data1         : out    vl_logic_vector(31 downto 0);
        o_data2         : out    vl_logic_vector(31 downto 0);
        o_imm           : out    vl_logic_vector(31 downto 0);
        o_rs            : out    vl_logic_vector(4 downto 0);
        o_rt            : out    vl_logic_vector(4 downto 0);
        o_rd            : out    vl_logic_vector(4 downto 0)
    );
end Reg_ID_EX;
