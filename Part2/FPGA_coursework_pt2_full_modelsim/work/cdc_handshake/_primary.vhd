library verilog;
use verilog.vl_types.all;
entity cdc_handshake is
    port(
        reset           : in     vl_logic;
        clk_a           : in     vl_logic;
        amp_in          : in     vl_logic_vector(10 downto 0);
        mode_in         : in     vl_logic;
        valid_a         : in     vl_logic;
        ready_a         : out    vl_logic;
        clk_b           : in     vl_logic;
        amp_out         : out    vl_logic_vector(10 downto 0);
        mode_out        : out    vl_logic;
        valid_b         : out    vl_logic
    );
end cdc_handshake;
