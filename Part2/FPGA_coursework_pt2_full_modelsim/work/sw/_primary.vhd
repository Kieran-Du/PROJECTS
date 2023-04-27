library verilog;
use verilog.vl_types.all;
entity sw is
    generic(
        CNT_MAX         : vl_logic_vector(0 to 12) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sw_in           : in     vl_logic;
        sw_valid        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_MAX : constant is 1;
end sw;
