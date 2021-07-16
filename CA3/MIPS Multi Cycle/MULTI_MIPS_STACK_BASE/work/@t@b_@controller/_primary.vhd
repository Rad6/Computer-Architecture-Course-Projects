library verilog;
use verilog.vl_types.all;
entity TB_Controller is
    generic(
        \_push\         : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0);
        \_pop\          : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi1);
        \_jmp\          : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi0);
        \_jz\           : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi1);
        \_add\          : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        \_sub\          : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        \_and\          : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        \_not\          : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of \_push\ : constant is 2;
    attribute mti_svvh_generic_type of \_pop\ : constant is 2;
    attribute mti_svvh_generic_type of \_jmp\ : constant is 2;
    attribute mti_svvh_generic_type of \_jz\ : constant is 2;
    attribute mti_svvh_generic_type of \_add\ : constant is 2;
    attribute mti_svvh_generic_type of \_sub\ : constant is 2;
    attribute mti_svvh_generic_type of \_and\ : constant is 2;
    attribute mti_svvh_generic_type of \_not\ : constant is 2;
end TB_Controller;
