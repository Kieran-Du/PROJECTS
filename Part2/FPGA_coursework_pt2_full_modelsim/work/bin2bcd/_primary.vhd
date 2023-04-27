library verilog;
use verilog.vl_types.all;
entity bin2bcd is
    generic(
        W               : integer := 18
    );
    port(
        bin             : in     vl_logic_vector;
        bcd             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of W : constant is 1;
end bin2bcd;
