read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {D:/G5_SOC/DSP/FIR_FILTER/DSP_FIR_FILTER_new _50_sw/designer/IGL2_FIR_FILTER/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER_layout_combinational_loops.xml}
report -type slack {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER_place_and_route_constraint_coverage.xml}]
set reportfile {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp