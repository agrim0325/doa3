open_project -project {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP_fp\TOP.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S010} \
    -fpga {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.map} \
    -header {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.hdr} \
    -envm {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.efc} \
    -spm {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.spm} \
    -dca {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.dca}
export_single_ppd \
    -name {M2S010} \
    -file {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.ppd}

export_single_dat \
    -name {M2S010} \
    -file {D:\goa\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.dat} \
    -secured

save_project
close_project
