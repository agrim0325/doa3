set_device \
    -family  SmartFusion2 \
    -die     PA4M1000_N \
    -package vf256 \
    -speed   -1 \
    -tempr   {IND} \
    -voltr   {IND}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def {PLL_SUPPLY} {PLL_SUPPLY_25}
set_def {VPP_SUPPLY_25_33} {VPP_SUPPLY_25}
set_def {PA4_URAM_FF_CONFIG} {SUSPEND}
set_def {PA4_SRAM_FF_CONFIG} {SUSPEND}
set_def {PA4_MSS_FF_CLOCK} {RCOSC_1MHZ}
set_def USE_CONSTRAINTS_FLOW 1
set_netlist -afl {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.afl} -adl {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.adl}
set_placement   {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.loc}
set_routing     {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.seg}
set_sdcfilelist -sdc {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new\constraint\IGL2_FIR_FILTER_derived_constraints.sdc}
