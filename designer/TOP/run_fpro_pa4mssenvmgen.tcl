set_device \
    -fam SmartFusion2 \
    -die PA4M1000_N \
    -pkg vf256
set_input_cfg \
	-path {D:/goa/doa-main/HF10_OV7725_LCD_FF/HF10_OV7725_LCD_FF/component/work/FlashFreeze_SB_MSS/ENVM.cfg}
set_output_efc \
    -path {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.efc}
set_proj_dir \
    -path {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF}
set_is_relative_path \
    -value {FALSE}
set_root_path_dir \
    -path {}
gen_prg -use_init false
