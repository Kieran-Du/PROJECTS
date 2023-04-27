library verilog;
use verilog.vl_types.all;
entity top_sig is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        dac_sdi         : out    vl_logic;
        dac_cs          : out    vl_logic;
        dac_sck         : out    vl_logic;
        dac_ld          : out    vl_logic
    );
end top_sig;
