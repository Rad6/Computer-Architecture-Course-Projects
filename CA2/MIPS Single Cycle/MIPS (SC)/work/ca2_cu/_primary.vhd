library verilog;
use verilog.vl_types.all;
entity ca2_cu is
    port(
        inst            : in     vl_logic_vector(15 downto 0);
        zero            : in     vl_logic;
        rf_write        : out    vl_logic;
        alu_sel         : out    vl_logic;
        alu_src         : out    vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        memtoreg        : out    vl_logic;
        rf_wnd          : out    vl_logic_vector(2 downto 0);
        op              : out    vl_logic_vector(2 downto 0);
        pc_src          : out    vl_logic_vector(1 downto 0)
    );
end ca2_cu;
