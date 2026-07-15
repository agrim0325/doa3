# Written by Synplify Pro version mapact, Build 2461R. Synopsys Run ID: sid1559046390 
# Top Level Design Parameters 

# Clocks 
create_clock -period 20.000 -waveform {0.000 10.000} -name {OSC_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {OSC_0/I_RCOSC_25_50MHZ/CLKOUT}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {led_blink|clkout_inferred_clock} [get_pins {led_blink_0/clkout/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {fft_inpl_slowClock|divider_inferred_clock[2]} [get_pins {COREFFT_0/genblk1.DUT_INPLACE/slowClock_0/divider[2]/Q}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {FCCC_0/GL0} -multiply_by {12} -divide_by {4} -source [get_pins {OSC_0/I_RCOSC_25_50MHZ/CLKOUT}]  [get_pins {FCCC_0/CCC_INST/GL0}] 
create_generated_clock -name {FCCC_0/GL1} -multiply_by {12} -divide_by {4} -source [get_pins {OSC_0/I_RCOSC_25_50MHZ/CLKOUT}]  [get_pins {FCCC_0/CCC_INST/GL1}] 
create_generated_clock -name {FCCC_0/GL2} -multiply_by {12} -divide_by {6} -source [get_pins {OSC_0/I_RCOSC_25_50MHZ/CLKOUT}]  [get_pins {FCCC_0/CCC_INST/GL2}] 
create_generated_clock -name {FCCC_0/GL3} -multiply_by {12} -divide_by {6} -source [get_pins {OSC_0/I_RCOSC_25_50MHZ/CLKOUT}]  [get_pins {FCCC_0/CCC_INST/GL3}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

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
set_clock_groups -asynchronous -group [get_clocks {fft_inpl_slowClock|divider_inferred_clock[2]}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -through [get_pins { SYSRESET_0.POWER_ON_RESET_N }]

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

