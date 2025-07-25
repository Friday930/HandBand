## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


## Switches
# set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
# set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
# set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
# set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {sw_mode[0]}]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {sw_mode[1]}]
# set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {sw_green[2]}]
# set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {sw_green[3]}]
# set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports threshold[0]]
# set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports threshold[1]]
# set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports threshold[2]]
# set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports threshold[3]]
# set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports threshold[4]]
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports threshold[5]]
# set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports threshold[6]]
# set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports threshold[7]]


## LEDs
# set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {led1[0]}]
# set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {led1[1]}]
# set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {led1[2]}]
# set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {led1[3]}]
# set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports {led1[4]}]
# set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports {green_port[1]}]
# set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {green_port[2]}]
# set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {green_port[3]}]
# set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports {red_port[0]}]
# set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports {red_port[1]}]
# set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports {red_port[2]}]
# set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports {led2[0]}]
# set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports {led2[1]}]
# set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports {led2[2]}]
# set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {led2[3]}]
# set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {led2[4]}]


##7 Segment Display
# set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {fndFont[0]}]
# set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {fndFont[1]}]
# set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {fndFont[2]}]
# set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {fndFont[3]}]
# set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {fndFont[4]}]
# set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {fndFont[5]}]
# set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {fndFont[6]}]
# set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports {fndFont[7]}]

# set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {fndCom[0]}]
# set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {fndCom[1]}]
# set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {fndCom[2]}]
# set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {fndCom[3]}]


##Buttons
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports reset]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports ov7670_start]
# set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports play]
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports btnR]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports btnD]


##Pmod Header JA
# set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports ov7670_href_debug];#Sch name = JA1
# set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports ov7670_v_sync_debug];#Sch name = JA2
# set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports out_text_en];#Sch name = JA3
# set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports DE_debug];#Sch name = JA4
# set_property -dict { PACKAGE_PIN H1   IOSTANDARD LVCMOS33 } [get_ports h_sync_debug];#Sch name = JA7
# set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports v_sync_debug];#Sch name = JA8
#set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports {JA[6]}];#Sch name = JA9
# set_property -dict { PACKAGE_PIN G3   IOSTANDARD LVCMOS33 } [get_ports PWM_signal];#Sch name = JA10

##Pmod Header JB
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports ov7670_v_sync];#Sch name = JB1
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports ov7670_pclk];#Sch name = JB2
# set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports ov7670_href];#Sch name = JB2
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports ov7670_scl];#Sch name = JB3
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports ov7670_sda];#Sch name = JB4
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports ov7670_href];#Sch name = JB7
# set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports ov7670_pclk];#Sch name = JB7
# set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports ov7670_xclk];#Sch name = JB8
# set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports ov7670_href];#Sch name = JB9
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports ov7670_xclk];#Sch name = JB10

##Pmod Header JC
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[7]}];#Sch name = JC1
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[5]}];#Sch name = JC2
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[3]}];#Sch name = JC3
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[1]}];#Sch name = JC4
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[6]}];#Sch name = JC7
set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[4]}];#Sch name = JC8
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[2]}];#Sch name = JC9
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[0]}];#Sch name = JC10

##Pmod Header JXADC
# set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[0]}];#Sch name = XA1_P
# set_property -dict { PACKAGE_PIN L3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[1]}];#Sch name = XA2_P
# set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[2]}];#Sch name = XA3_P
# set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[3]}];#Sch name = XA4_P
# set_property -dict { PACKAGE_PIN K3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[4]}];#Sch name = XA1_N
# set_property -dict { PACKAGE_PIN M3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[5]}];#Sch name = XA2_N
# set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[6]}];#Sch name = XA3_N
# set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[7]}];#Sch name = XA4_N


##VGA Connector
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports {red_port[0]}]
set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports {red_port[1]}]
set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports {red_port[2]}]
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports {red_port[3]}]
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports {blue_port[0]}]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {blue_port[1]}]
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports {blue_port[2]}]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {blue_port[3]}]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {green_port[0]}]
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {green_port[1]}]
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports {green_port[2]}]
set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports {green_port[3]}]
set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports Hsync]
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports Vsync]


##USB-RS232 Interface
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports rx]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports tx]


##USB HID (PS/2)
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Clk]
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[0]}]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[1]}]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[2]}]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[3]}]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports QspiCSn]

# RED
set_property DRIVE 8 [get_ports red_port[0]]
set_property SLEW FAST [get_ports red_port[0]]
set_property DRIVE 8 [get_ports red_port[1]]
set_property SLEW FAST [get_ports red_port[1]]
set_property DRIVE 8 [get_ports red_port[2]]
set_property SLEW FAST [get_ports red_port[2]]
set_property DRIVE 8 [get_ports red_port[3]]
set_property SLEW FAST [get_ports red_port[3]]

# GREEN
set_property DRIVE 8 [get_ports green_port[0]]
set_property SLEW FAST [get_ports green_port[0]]
set_property DRIVE 8 [get_ports green_port[1]]
set_property SLEW FAST [get_ports green_port[1]]
set_property DRIVE 8 [get_ports green_port[2]]
set_property SLEW FAST [get_ports green_port[2]]
set_property DRIVE 8 [get_ports green_port[3]]
set_property SLEW FAST [get_ports green_port[3]]

# BLUE
set_property DRIVE 8 [get_ports blue_port[0]]
set_property SLEW FAST [get_ports blue_port[0]]
set_property DRIVE 8 [get_ports blue_port[1]]
set_property SLEW FAST [get_ports blue_port[1]]
set_property DRIVE 8 [get_ports blue_port[2]]
set_property SLEW FAST [get_ports blue_port[2]]
set_property DRIVE 8 [get_ports blue_port[3]]
set_property SLEW FAST [get_ports blue_port[3]]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]