set_family {SmartFusion2}
read_adl {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.adl}
read_afl {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.afl}
map_netlist
read_sdc {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\constraint\IGL2_FIR_FILTER_derived_constraints.sdc}
check_constraints {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\constraint\placer_sdc_errors.log}
write_sdc -strict -afl {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\place_route.sdc}
