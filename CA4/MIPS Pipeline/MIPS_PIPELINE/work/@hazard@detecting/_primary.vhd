library verilog;
use verilog.vl_types.all;
entity HazardDetecting is
    port(
        ID_rt           : in     vl_logic_vector(4 downto 0);
        ID_rs           : in     vl_logic_vector(4 downto 0);
        EX_rt           : in     vl_logic_vector(4 downto 0);
        EX_memread      : in     vl_logic;
        hazard_detected : out    vl_logic
    );
end HazardDetecting;
