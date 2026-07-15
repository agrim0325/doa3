# Microsemi Corp.
# Date: 2019-Oct-17 10:53:16
# This file was generated based on the following SDC source files:
#   C:/Hello_fpga_12_2/HF10_OV7725_LCD_FF/component/work/FlashFreeze_SB/CCC_0/FlashFreeze_SB_CCC_0_FCCC.sdc
#   C:/Hello_fpga_12_2/HF10_OV7725_LCD_FF/component/work/FlashFreeze_SB_MSS/FlashFreeze_SB_MSS.sdc
#   C:/Hello_fpga_12_2/HF10_OV7725_LCD_FF/component/work/OSC_C0/OSC_C0_0/OSC_C0_OSC_C0_0_OSC.sdc
#   C:/Microsemi/Libero_SoC_v12.2/Designer/data/aPA4M/cores/constraints/sysreset.sdc
#

create_clock -name {OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL0} -multiply_by 24 -divide_by 12 -source [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/GL0 } ]
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL1} -multiply_by 24 -divide_by 50 -source [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/GL1 } ]
set_false_path -ignore_errors -through [ get_pins { FlashFreeze_SB_0/FlashFreeze_SB_MSS_0/MSS_ADLIB_INST/CONFIG_PRESET_N } ]
set_false_path -ignore_errors -through [ get_pins { SYSRESET_0/POWER_ON_RESET_N } ]
