set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_adl {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.adl}
read_afl {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.afl}
map_netlist
read_sdc {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\constraint\TOP_derived_constraints.sdc}
check_constraints {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\constraint\placer_sdc_errors.log}
write_sdc -mode layout {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\place_route.sdc}
