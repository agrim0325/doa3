set_component FlashFreeze_SB_CCC_0_FCCC
# Microsemi Corp.
# Date: 2019-Aug-23 12:06:59
#

create_clock -period 20 [ get_pins { CCC_INST/RCOSC_25_50MHZ } ]
create_generated_clock -multiply_by 24 -divide_by 12 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
create_generated_clock -multiply_by 24 -divide_by 50 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL1 } ]
