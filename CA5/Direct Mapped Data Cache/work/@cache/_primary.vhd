library verilog;
use verilog.vl_types.all;
entity Cache is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        write           : in     vl_logic;
        i_data          : in     vl_logic_vector(127 downto 0);
        adr             : in     vl_logic_vector(14 downto 0);
        hit             : out    vl_logic;
        o_data          : out    vl_logic_vector(31 downto 0)
    );
end Cache;
