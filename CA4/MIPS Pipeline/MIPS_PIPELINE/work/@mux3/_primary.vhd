library verilog;
use verilog.vl_types.all;
entity Mux3 is
    generic(
        n               : vl_notype
    );
    port(
        x               : in     vl_logic_vector;
        y               : in     vl_logic_vector;
        z               : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 5;
end Mux3;
