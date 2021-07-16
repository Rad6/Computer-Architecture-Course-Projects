library verilog;
use verilog.vl_types.all;
entity DP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        adr             : in     vl_logic_vector(14 downto 0);
        done            : out    vl_logic;
        hit_cnt         : out    vl_logic_vector(12 downto 0);
        o_data          : out    vl_logic_vector(31 downto 0)
    );
end DP;
