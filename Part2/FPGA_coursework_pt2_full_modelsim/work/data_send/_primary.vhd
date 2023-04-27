library verilog;
use verilog.vl_types.all;
entity data_send is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        fre_bcd         : in     vl_logic_vector(15 downto 0);
        amp_bcd         : in     vl_logic_vector(11 downto 0);
        valid           : in     vl_logic;
        ready           : out    vl_logic;
        tx              : out    vl_logic
    );
end data_send;
