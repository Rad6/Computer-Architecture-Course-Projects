library verilog;
use verilog.vl_types.all;
entity HazardDetecting is
    port(
        EX_memread      : in     vl_logic;
        eq              : in     vl_logic;
        ID_rt           : in     vl_logic_vector(4 downto 0);
        ID_rs           : in     vl_logic_vector(4 downto 0);
        EX_rt           : in     vl_logic_vector(4 downto 0);
        opc             : in     vl_logic_vector(5 downto 0);
        pc_ld           : out    vl_logic;
        IF_ID_reg_ld    : out    vl_logic;
        hazard_detected : out    vl_logic;
        flush           : out    vl_logic;
        is_beq          : out    vl_logic;
        is_bne          : out    vl_logic;
        is_jmp          : out    vl_logic
    );
end HazardDetecting;
