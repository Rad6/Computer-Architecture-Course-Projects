library verilog;
use verilog.vl_types.all;
entity RF is
    port(
        in1             : in     vl_logic_vector(1 downto 0);
        in2             : in     vl_logic_vector(1 downto 0);
        wrR             : in     vl_logic_vector(1 downto 0);
        sig_wnd         : in     vl_logic_vector(2 downto 0);
        data            : in     vl_logic_vector(15 downto 0);
        sig_write       : in     vl_logic;
        out1            : out    vl_logic_vector(15 downto 0);
        out2            : out    vl_logic_vector(15 downto 0)
    );
end RF;
