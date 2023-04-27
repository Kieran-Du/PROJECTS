library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        btn_in_0        : in     vl_logic;
        btn_in_1        : in     vl_logic;
        btn_in_2        : in     vl_logic;
        btn_in_3        : in     vl_logic;
        sw_in_0         : in     vl_logic;
        div_valid       : out    vl_logic;
        div_value       : out    vl_logic_vector(17 downto 0);
        amp_value       : out    vl_logic_vector(10 downto 0);
        mode            : out    vl_logic;
        valid_dds       : out    vl_logic;
        ready_dds       : in     vl_logic;
        fre_bcd         : out    vl_logic_vector(15 downto 0);
        amp_bcd         : out    vl_logic_vector(11 downto 0);
        valid_uart      : out    vl_logic;
        ready_uart      : in     vl_logic
    );
end ctrl;
