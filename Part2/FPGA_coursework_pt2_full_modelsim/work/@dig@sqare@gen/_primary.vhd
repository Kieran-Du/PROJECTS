library verilog;
use verilog.vl_types.all;
entity DigSqareGen is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        amp             : in     vl_logic_vector(10 downto 0);
        y               : out    vl_logic_vector(9 downto 0);
        handshake       : out    vl_logic
    );
end DigSqareGen;
