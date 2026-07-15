# Microsemi Corp.
# Date: 2019-May-28 16:51:31
# This file was generated based on the following SDC source files:
#   D:/G5_SOC/DSP/FIR_FILTER/DSP_FIR_FILTER_new _50_sw/constraint/IGL2_FIR_FILTER_derived_constraints.sdc
#

create_clock -name {OSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { OSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {FCCC_0/GL0} -multiply_by 12 -divide_by 4 -source [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/GL0 } ]
create_generated_clock -name {FCCC_0/GL1} -multiply_by 12 -divide_by 4 -source [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/GL1 } ]
create_generated_clock -name {FCCC_0/GL2} -multiply_by 12 -divide_by 6 -source [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FCCC_0/CCC_INST/INST_CCC_IP/GL2 } ]
set_false_path -through [ get_pins { SYSRESET_0/INST_SYSRESET_FF_IP/POWER_ON_RESET_N } ]
