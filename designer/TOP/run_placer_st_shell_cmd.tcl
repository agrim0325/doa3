read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {E:/finaldestination/doa-main/HF10_OV7725_LCD_FF/HF10_OV7725_LCD_FF/designer/TOP/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP_layout_combinational_loops.xml}
report -type slack {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\TOP_place_and_route_constraint_coverage.xml}]
set reportfile {E:\finaldestination\doa-main\HF10_OV7725_LCD_FF\HF10_OV7725_LCD_FF\designer\TOP\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp