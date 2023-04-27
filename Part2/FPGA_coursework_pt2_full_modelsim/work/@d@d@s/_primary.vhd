library verilog;
use verilog.vl_types.all;
entity DDS is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        amp             : in     vl_logic_vector(10 downto 0);
        mode            : in     vl_logic;
        valid           : in     vl_logic;
        data_out        : out    vl_logic_vector(9 downto 0);
        handshake       : out    vl_logic
    );
end DDS;
