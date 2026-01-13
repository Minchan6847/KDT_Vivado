# CLK_125M
set_property IOSTANDARD LVCMOS33 [get_ports clk_125MHz]
set_property PACKAGE_PIN K17 [get_ports clk_125MHz]

# BTN for RST
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN Y16 [get_ports rst]

# BTN input (BTN SW)
set_property IOSTANDARD LVCMOS33 [get_ports btn_sw]
set_property PACKAGE_PIN K19 [get_ports btn_sw]

# tx_data (DIP SW)
set_property IOSTANDARD LVCMOS33 [get_ports {dip_sw[*]}]
set_property PACKAGE_PIN T16 [get_ports {dip_sw[3]}] 
set_property PACKAGE_PIN W13 [get_ports {dip_sw[2]}] 
set_property PACKAGE_PIN P15 [get_ports {dip_sw[1]}] 
set_property PACKAGE_PIN G15 [get_ports {dip_sw[0]}] 

# UART TXD (Pmod JA)
set_property IOSTANDARD LVCMOS33 [get_ports uart_txd]
set_property PACKAGE_PIN L14 [get_ports uart_txd]

