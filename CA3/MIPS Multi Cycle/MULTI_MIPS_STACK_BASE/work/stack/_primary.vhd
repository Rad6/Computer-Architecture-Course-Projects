library verilog;
use verilog.vl_types.all;
entity stack is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        tos             : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        d_in            : in     vl_logic_vector(7 downto 0);
        d_out           : out    vl_logic_vector(7 downto 0)
    );
end stack;
