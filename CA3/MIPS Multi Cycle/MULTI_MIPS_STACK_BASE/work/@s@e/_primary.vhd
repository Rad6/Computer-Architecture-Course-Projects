library verilog;
use verilog.vl_types.all;
entity SE is
    port(
        five_bit_in     : in     vl_logic_vector(4 downto 0);
        eight_bit_out   : out    vl_logic_vector(7 downto 0)
    );
end SE;
