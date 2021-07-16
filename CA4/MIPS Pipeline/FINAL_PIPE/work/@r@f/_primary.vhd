library verilog;
use verilog.vl_types.all;
entity RF is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        write           : in     vl_logic;
        r1              : in     vl_logic_vector(4 downto 0);
        r2              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        data            : in     vl_logic_vector(31 downto 0);
        out1            : out    vl_logic_vector(31 downto 0);
        out2            : out    vl_logic_vector(31 downto 0)
    );
end RF;
