library verilog;
use verilog.vl_types.all;
entity Cach_CU is
    generic(
        IDLE            : integer := 0;
        HITING          : integer := 1;
        WAITING         : integer := 2;
        MISING          : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        hit             : in     vl_logic;
        mem_ready       : in     vl_logic;
        read            : out    vl_logic;
        done            : out    vl_logic;
        write           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of HITING : constant is 1;
    attribute mti_svvh_generic_type of WAITING : constant is 1;
    attribute mti_svvh_generic_type of MISING : constant is 1;
end Cach_CU;
