library verilog;
use verilog.vl_types.all;
entity DP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        pcwrite         : in     vl_logic;
        pcwritecond     : in     vl_logic;
        pcsrc           : in     vl_logic;
        PorI            : in     vl_logic;
        memread         : in     vl_logic;
        memwrite        : in     vl_logic;
        IRwrite         : in     vl_logic;
        MtoS            : in     vl_logic;
        ldA             : in     vl_logic;
        ldB             : in     vl_logic;
        srcA            : in     vl_logic;
        srcB            : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        tos             : in     vl_logic;
        ALUop           : in     vl_logic_vector(1 downto 0);
        opc             : out    vl_logic_vector(2 downto 0)
    );
end DP;
