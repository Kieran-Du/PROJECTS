library verilog;
use verilog.vl_types.all;
entity dataROM is
    port(
        clock           : in     vl_logic;
        address         : in     vl_logic_vector(0 to 8);
        dataOut         : out    vl_logic_vector(9 downto 0)
    );
end dataROM;
