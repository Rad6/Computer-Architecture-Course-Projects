library verilog;
use verilog.vl_types.all;
entity IM is
    port(
        adr             : in     vl_logic_vector(31 downto 0);
        inst            : out    vl_logic_vector(31 downto 0)
    );
end IM;
