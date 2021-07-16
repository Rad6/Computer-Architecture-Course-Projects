library verilog;
use verilog.vl_types.all;
entity IfZero is
    generic(
        n               : vl_notype
    );
    port(
        data            : in     vl_logic_vector;
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 5;
end IfZero;
