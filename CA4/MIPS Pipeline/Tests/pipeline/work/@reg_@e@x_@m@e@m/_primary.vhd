library verilog;
use verilog.vl_types.all;
entity Reg_EX_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        i_RegWrite      : in     vl_logic;
        i_MemToReg      : in     vl_logic;
        i_MemRead       : in     vl_logic;
        i_MemWrite      : in     vl_logic;
        i_alu           : in     vl_logic_vector(31 downto 0);
        i_reg           : in     vl_logic_vector(4 downto 0);
        i_that          : in     vl_logic_vector(31 downto 0);
        o_RegWrite      : out    vl_logic;
        o_MemToReg      : out    vl_logic;
        o_MemRead       : out    vl_logic;
        o_MemWrite      : out    vl_logic;
        o_alu           : out    vl_logic_vector(31 downto 0);
        o_reg           : out    vl_logic_vector(4 downto 0);
        o_that          : out    vl_logic_vector(31 downto 0)
    );
end Reg_EX_MEM;
