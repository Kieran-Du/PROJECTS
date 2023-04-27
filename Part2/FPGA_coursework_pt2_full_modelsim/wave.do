onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/u_top/clk
add wave -noupdate /tb_top/u_top/reset
add wave -noupdate -group ctr_in /tb_top/u_top/sw0_in
add wave -noupdate -group ctr_in /tb_top/u_top/btn0_in
add wave -noupdate -group ctr_in /tb_top/u_top/btn1_in
add wave -noupdate -group ctr_in /tb_top/u_top/btn2_in
add wave -noupdate -group ctr_in /tb_top/u_top/btn3_in
add wave -noupdate -group spi2dac /tb_top/u_top/dac_sdi
add wave -noupdate -group spi2dac /tb_top/u_top/u_spi2dac/load
add wave -noupdate -group spi2dac /tb_top/u_top/dac_cs
add wave -noupdate -group spi2dac /tb_top/u_top/dac_sck
add wave -noupdate -group spi2dac /tb_top/u_top/dac_ld
add wave -noupdate -group sig_out -max 953.99999999999989 -min 22.0 -radix unsigned /tb_top/u_top/u_DDS/data_out
add wave -noupdate -group sig_out -max 265.00000000000006 -min -294.0 -radix unsigned /tb_top/u_top/u_DDS/data_out_sine
add wave -noupdate -group sig_out -max 1023.0 -min 1.0 -radix unsigned /tb_top/u_top/u_DDS/data_out_sqare
add wave -noupdate -group clk_div /tb_top/u_top/u_clk_div/clk_div
add wave -noupdate -group clk_div /tb_top/u_top/u_clk_div/clk_div_valid
add wave -noupdate -group clk_div /tb_top/u_top/u_clk_div/clk_DDS
add wave -noupdate -group clk_div /tb_top/u_top/u_clk_div/clk_50M
add wave -noupdate -expand -group uart_tx /tb_top/u_top/u_data_send/valid
add wave -noupdate -expand -group uart_tx /tb_top/u_top/u_data_send/ready
add wave -noupdate -expand -group uart_tx /tb_top/u_top/u_data_send/tx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7150005 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {105 ms}
