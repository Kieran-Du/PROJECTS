library verilog;
use verilog.vl_types.all;
entity uart_tx is
    generic(
        BAUDRATE        : integer := 115200;
        CLKRATE         : integer := 100000000
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        valid           : in     vl_logic;
        data            : in     vl_logic_vector(7 downto 0);
        ready           : out    vl_logic;
        tx              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BAUDRATE : constant is 1;
    attribute mti_svvh_generic_type of CLKRATE : constant is 1;
end uart_tx;
