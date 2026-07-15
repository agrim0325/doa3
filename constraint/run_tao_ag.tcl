set_device -family {SmartFusion2} -die {M2S010}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\FF_EXT.v}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\FF_GENERATOR.vhd}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\coreresetp_pcie_hotreset.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\coreresetp.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\CORERESETP_0.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\FlashFreeze_SB\CCC_0\FlashFreeze_SB_CCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\FlashFreeze_SB_MSS\FlashFreeze_SB_MSS.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\FlashFreeze_SB\FlashFreeze_SB.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\OSC_C0\OSC_C0_0\OSC_C0_OSC_C0_0_OSC.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\OSC_C0\OSC_C0.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0_0\rtl\vlog\core_obfuscated\Rx_async.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0_0\rtl\vlog\core_obfuscated\Tx_async.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0_0\rtl\vlog\core_obfuscated\fifo_256x8_g4.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0_0\rtl\vlog\core_obfuscated\Clock_gen.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0_0\rtl\vlog\core_obfuscated\CoreUART.v}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\COREUART_C0\COREUART_C0.v}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\addr_decoder.vhd}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\receive_data.vhd}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\UART_interface\UART_interface.v}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\apb3_if.vhd}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\led_blink.v}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\Image_Enhancement.vhd}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\LCD_FSM.vhd}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\Write_LSRAM.vhd}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\double_flop.vhd}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\RamDualPort.vhd}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\line_write_read\line_write_read.v}
read_vhdl -mode vhdl_2008 {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\hdl\mux_2_1.vhd}
read_verilog -mode verilog_2k {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\TOP\TOP.v}
set_top_level {TOP}
read_sdc -component {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\FlashFreeze_SB\CCC_0\FlashFreeze_SB_CCC_0_FCCC.sdc}
read_sdc -component {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\FlashFreeze_SB_MSS\FlashFreeze_SB_MSS.sdc}
read_sdc -component {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\component\work\OSC_C0\OSC_C0_0\OSC_C0_OSC_C0_0_OSC.sdc}
derive_constraints
write_sdc {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\constraint\TOP_derived_constraints.sdc}
write_pdc {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\constraint\fp\TOP_derived_constraints.pdc}
