# Written by Synplify Pro version map202503actsp1, Build 108R. Synopsys Run ID: sid1784080249 
# Top Level Design Parameters 

# Clocks 
create_clock -period 20.000 -waveform {0.000 10.000} -name {OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {led_blink|clkout_inferred_clock} [get_pins {led_blink_0/clkout/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {FlashFreeze_SB|BIBUF_1_Y_inferred_clock} [get_pins {FlashFreeze_SB_0/BIBUF_1/Y}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL0} -multiply_by {24} -divide_by {12} -source [get_pins {FlashFreeze_SB_0/CCC_0/CCC_INST/RCOSC_25_50MHZ}]  [get_pins {FlashFreeze_SB_0/CCC_0/CCC_INST/GL0}] 
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL1} -multiply_by {24} -divide_by {50} -source [get_pins {FlashFreeze_SB_0/CCC_0/CCC_INST/RCOSC_25_50MHZ}]  [get_pins {FlashFreeze_SB_0/CCC_0/CCC_INST/GL1}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 
set_false_path -through [get_pins {SYSRESET_0/POWER_ON_RESET_N}] 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {led_blink|clkout_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {FlashFreeze_SB|BIBUF_1_Y_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -through [get_pins { FlashFreeze_SB_0.FlashFreeze_SB_MSS_0.MSS_ADLIB_INST.CONFIG_PRESET_N }]


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

