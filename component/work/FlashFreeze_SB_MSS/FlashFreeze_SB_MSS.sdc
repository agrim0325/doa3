set_component FlashFreeze_SB_MSS
# Microsemi Corp.
# Date: 2019-Jun-24 17:07:35
#

create_clock -period 40 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
set_false_path -ignore_errors -through [ get_pins { MSS_ADLIB_INST/CONFIG_PRESET_N } ]
