create_clock -name sys_clk -period 10 [get_ports clk]
create_generated_clock -name clk_50M [get_pins u_clk_div/clk_50M] -source [get_ports clk] -divide_by 2
create_generated_clock -name clk_DDS [get_pins u_clk_div/clk_DDS] -source [get_ports clk] -divide_by 20
set_clock_groups -asynchronous -group sys_clk -group clk_50M -group clk_DDS

set_false_path -from sys_clk -to clk_50M
set_false_path -from clk_50M -to clk_DDS

#set_false_path -through [get_pins u_cdc_handshake/amp_temp] -through [get_pins u_cdc_handshake/amp_out]
#set_false_path -through [get_pins u_cdc_handshake/mode_temp] -through [get_pins u_cdc_handshake/mode_out]
#set_false_path -through [get_pins u_cdc_handshake/response] -through [get_pins u_cdc_handshake/response_r]
#set_false_path -through [get_pins u_cdc_handshake/valid_cdc] -through [get_pins u_cdc_handshake/valid_cdc]
#set_false_path -through [get_pins handshake] -through [get_pins handshake_r]
#set_false_path -through [get_pins u_spi2dac/data_in] -through [get_pins u_spi2dac/shift_reg]

# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"


# ----------------------------------------------------------------------------
# JB Pmod - Bank 13
# ---------------------------------------------------------------------------- 

set_property PACKAGE_PIN W11 [get_ports {tx}];  # "JB2"





# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
#set_property PACKAGE_PIN T22 [get_ports {dac_sdi}];  # "LD0"
#set_property PACKAGE_PIN T21 [get_ports {dac_cs}];  # "LD1"
#set_property PACKAGE_PIN U22 [get_ports {dac_sck}];  # "LD2"
#set_property PACKAGE_PIN U21 [get_ports {dac_ld}];  # "LD3"
set_property PACKAGE_PIN Y11  [get_ports {dac_sdi}];  # "JA1"
set_property PACKAGE_PIN AA11 [get_ports {dac_cs}];  # "JA2"
set_property PACKAGE_PIN Y10  [get_ports {dac_sck}];  # "JA3"
set_property PACKAGE_PIN AA9  [get_ports {dac_ld}];  # "JA4"

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN P16 [get_ports {reset}];  # "BTNC"
set_property PACKAGE_PIN R16 [get_ports {btn2_in}];  # "BTND"
set_property PACKAGE_PIN N15 [get_ports {btn1_in}];  # "BTNL"
set_property PACKAGE_PIN R18 [get_ports {btn0_in}];  # "BTNR"
set_property PACKAGE_PIN T18 [get_ports {btn3_in}];  # "BTNU"


## ----------------------------------------------------------------------------
## User DIP Switches - Bank 35
## ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN F22 [get_ports {sw0_in}];  # "SW0"




# ----------------------------------------------------------------------------
# IOSTANDARD Constraints
#
# Note that these IOSTANDARD constraints are applied to all IOs currently
# assigned within an I/O bank.  If these IOSTANDARD constraints are 
# evaluated prior to other PACKAGE_PIN constraints being applied, then 
# the IOSTANDARD specified will likely not be applied properly to those 
# pins.  Therefore, bank wide IOSTANDARD constraints should be placed 
# within the XDC file in a location that is evaluated AFTER all 
# PACKAGE_PIN constraints within the target bank have been evaluated.
#
# Un-comment one or more of the following IOSTANDARD constraints according to
# the bank pin assignments that are required within a design.
# ---------------------------------------------------------------------------- 

# Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];

# Set the bank voltage for IO Bank 34 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];

# Set the bank voltage for IO Bank 35 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
