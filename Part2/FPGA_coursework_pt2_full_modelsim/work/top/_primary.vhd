library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sw0_in          : in     vl_logic;
        btn0_in         : in     vl_logic;
        btn1_in         : in     vl_logic;
        btn2_in         : in     vl_logic;
        btn3_in         : in     vl_logic;
        tx              : out    vl_logic;
        dac_sdi         : out    vl_logic;
        dac_cs          : out    vl_logic;
        dac_sck         : out    vl_logic;
        dac_ld          : out    vl_logic
    );
end top;
