library verilog;
use verilog.vl_types.all;
entity divider_cell is
    generic(
        N               : integer := 5;
        M               : integer := 3
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic;
        dividend        : in     vl_logic_vector;
        divisor         : in     vl_logic_vector;
        merchant_ci     : in     vl_logic_vector;
        dividend_ci     : in     vl_logic_vector;
        dividend_kp     : out    vl_logic_vector;
        divisor_kp      : out    vl_logic_vector;
        rdy             : out    vl_logic;
        merchant        : out    vl_logic_vector;
        remainder       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of M : constant is 1;
end divider_cell;
