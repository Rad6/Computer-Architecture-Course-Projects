library verilog;
use verilog.vl_types.all;
entity ForwardingUnit is
    port(
        MEM_WB_RegWrite : in     vl_logic;
        MEM_WB_Rd       : in     vl_logic_vector(4 downto 0);
        EX_MEM_RegWrite : in     vl_logic;
        EX_MEM_Rd       : in     vl_logic_vector(4 downto 0);
        ID_EX_Rs        : in     vl_logic_vector(4 downto 0);
        ID_EX_Rt        : in     vl_logic_vector(4 downto 0);
        ForwardingA     : out    vl_logic_vector(1 downto 0);
        ForwardingB     : out    vl_logic_vector(1 downto 0)
    );
end ForwardingUnit;
