library verilog;
use verilog.vl_types.all;
entity divider_man is
    generic(
        N               : integer := 5;
        M               : integer := 3;
        N_ACT           : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data_rdy        : in     vl_logic;
        dividend        : in     vl_logic_vector;
        divisor         : in     vl_logic_vector;
        res_rdy         : out    vl_logic;
        merchant        : out    vl_logic_vector;
        remainder       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of M : constant is 1;
    attribute mti_svvh_generic_type of N_ACT : constant is 3;
end divider_man;
