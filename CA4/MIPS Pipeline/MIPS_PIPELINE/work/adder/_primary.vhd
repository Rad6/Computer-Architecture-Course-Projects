library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        n               : vl_notype
    );
    port(
        x               : in     vl_logic_vector;
        y               : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 5;
end adder;
