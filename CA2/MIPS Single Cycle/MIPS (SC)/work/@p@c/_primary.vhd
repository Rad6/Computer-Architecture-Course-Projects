library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        \in\            : in     vl_logic_vector(9 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector(9 downto 0)
    );
end PC;
