library verilog;
use verilog.vl_types.all;
entity MIPS_DP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sig_pc_src      : in     vl_logic_vector(1 downto 0);
        sig_rf_write    : in     vl_logic;
        sig_alu_src     : in     vl_logic;
        sig_alu_sel     : in     vl_logic;
        sig_mem_write   : in     vl_logic;
        sig_mem_read    : in     vl_logic;
        sig_memtoreg    : in     vl_logic;
        sig_rf_wnd      : in     vl_logic_vector(2 downto 0);
        sig_op          : in     vl_logic_vector(2 downto 0);
        inst            : out    vl_logic_vector(15 downto 0);
        ans             : out    vl_logic_vector(15 downto 0);
        zero            : out    vl_logic
    );
end MIPS_DP;
