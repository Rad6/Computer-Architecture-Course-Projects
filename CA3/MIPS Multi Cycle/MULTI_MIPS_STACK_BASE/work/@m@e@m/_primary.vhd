library verilog;
use verilog.vl_types.all;
entity MEM is
    port(
        adr             : in     vl_logic_vector(4 downto 0);
        data            : in     vl_logic_vector(7 downto 0);
        sig_write       : in     vl_logic;
        sig_read        : in     vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end MEM;
