# Microsemi Corp.
# Date: 2019-May-28 11:00:42
# This file was generated based on the following SDC source files:
#   D:/G5_SOC/DSP/FIR_FILTER/DSP_FIR_FILTER_new/component/work/IGL2_FIR_FILTER/FCCC_0/IGL2_FIR_FILTER_FCCC_0_FCCC.sdc
#   D:/G5_SOC/DSP/FIR_FILTER/DSP_FIR_FILTER_new/component/work/IGL2_FIR_FILTER/OSC_0/IGL2_FIR_FILTER_OSC_0_OSC.sdc
#   C:/Microsemi/Libero_SoC_v12.1/Designer/data/aPA4M/cores/constraints/sysreset.sdc
#

create_clock -name {OSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { OSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {FCCC_0/GL0} -multiply_by 6 -divide_by 2 -source [ get_pins { FCCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/GL0 } ]
create_generated_clock -name {FCCC_0/GL1} -multiply_by 6 -divide_by 2 -source [ get_pins { FCCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/GL1 } ]
create_generated_clock -name {FCCC_0/GL2} -multiply_by 6 -divide_by 2 -source [ get_pins { FCCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/GL2 } ]
set_false_path -ignore_errors -through [ get_pins { SYSRESET_0/POWER_ON_RESET_N } ]

