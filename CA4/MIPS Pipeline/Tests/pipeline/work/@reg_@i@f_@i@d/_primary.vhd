library verilog;
use verilog.vl_types.all;
entity Reg_IF_ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        write           : in     vl_logic;
        i_pc            : in     vl_logic_vector(31 downto 0);
        i_inst          : in     vl_logic_vector(31 downto 0);
        o_pc            : out    vl_logic_vector(31 downto 0);
        o_inst          : out    vl_logic_vector(31 downto 0)
    );
end Reg_IF_ID;
