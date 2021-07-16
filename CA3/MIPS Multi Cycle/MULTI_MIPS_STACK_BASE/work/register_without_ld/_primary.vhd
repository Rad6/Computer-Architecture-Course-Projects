library verilog;
use verilog.vl_types.all;
entity register_without_ld is
    generic(
        n               : vl_notype
    );
    port(
        data            : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 5;
end register_without_ld;
