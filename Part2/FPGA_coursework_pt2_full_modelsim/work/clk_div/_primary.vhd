library verilog;
use verilog.vl_types.all;
entity clk_div is
    port(
        clk_in          : in     vl_logic;
        reset           : in     vl_logic;
        clk_div         : in     vl_logic_vector(17 downto 0);
        clk_div_valid   : in     vl_logic;
        clk_DDS         : out    vl_logic;
        clk_50M         : out    vl_logic
    );
end clk_div;
