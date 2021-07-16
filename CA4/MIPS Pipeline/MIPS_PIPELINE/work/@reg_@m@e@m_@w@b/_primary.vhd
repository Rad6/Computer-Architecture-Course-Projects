library verilog;
use verilog.vl_types.all;
entity Reg_MEM_WB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        i_RegWrite      : in     vl_logic;
        i_MemToReg      : in     vl_logic;
        i_mem_data      : in     vl_logic_vector(31 downto 0);
        i_alu_data      : in     vl_logic_vector(31 downto 0);
        i_rd            : in     vl_logic_vector(4 downto 0);
        o_RegWrite      : out    vl_logic;
        o_mem_data      : out    vl_logic_vector(31 downto 0);
        o_alu_data      : out    vl_logic_vector(31 downto 0);
        o_rd            : out    vl_logic_vector(4 downto 0)
    );
end Reg_MEM_WB;
