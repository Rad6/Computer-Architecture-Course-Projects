library verilog;
use verilog.vl_types.all;
entity MEM is
    port(
        write           : in     vl_logic;
        read            : in     vl_logic;
        adr             : in     vl_logic_vector(14 downto 0);
        data            : in     vl_logic_vector(31 downto 0);
        ready           : out    vl_logic;
        \out\           : out    vl_logic_vector(127 downto 0)
    );
end MEM;
