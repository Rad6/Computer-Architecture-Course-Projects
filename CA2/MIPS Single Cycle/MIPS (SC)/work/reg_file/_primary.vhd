library verilog;
use verilog.vl_types.all;
entity reg_file is
    port(
        read_in_1       : in     vl_logic_vector(1 downto 0);
        read_in_2       : in     vl_logic_vector(1 downto 0);
        write_reg       : in     vl_logic_vector(1 downto 0);
        wnd             : in     vl_logic_vector(2 downto 0);
        write_data      : in     vl_logic_vector(15 downto 0);
        write_to_reg    : in     vl_logic;
        read_out_1      : out    vl_logic_vector(15 downto 0);
        read_out_2      : out    vl_logic_vector(15 downto 0)
    );
end reg_file;
