library verilog;
use verilog.vl_types.all;
entity DigSineGenerator is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        y2_init         : in     vl_logic_vector(10 downto 0);
        valid           : in     vl_logic;
        y               : out    vl_logic_vector(9 downto 0);
        handshake       : out    vl_logic
    );
end DigSineGenerator;
