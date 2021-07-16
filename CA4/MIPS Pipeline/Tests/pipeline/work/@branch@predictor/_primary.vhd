library verilog;
use verilog.vl_types.all;
entity BranchPredictor is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        eq              : out    vl_logic
    );
end BranchPredictor;
