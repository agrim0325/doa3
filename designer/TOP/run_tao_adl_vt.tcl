set_family {SmartFusion2}
read_adl {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\designer\TOP\TOP.adl}
read_afl {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\designer\TOP\TOP.afl}
map_netlist
read_sdc {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\constraint\TOP_derived_constraints.sdc}
check_constraints {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\constraint\timing_sdc_errors.log}
write_sdc -strict -afl {C:\Hello_fpga_12_2\HF10_OV7725_LCD_FF\designer\TOP\timing_analysis.sdc}
