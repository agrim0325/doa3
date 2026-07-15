open_project -project {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP_fp\TOP.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S010} \
    -fpga {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.map} \
    -header {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.hdr} \
    -envm {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.efc} \
    -spm {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.spm} \
    -dca {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP.dca}
export_single_ppd \
    -name {M2S010} \
    -file {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.ppd}

export_single_dat \
    -name {M2S010} \
    -file {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.dat} \
    -secured

save_project
close_project
