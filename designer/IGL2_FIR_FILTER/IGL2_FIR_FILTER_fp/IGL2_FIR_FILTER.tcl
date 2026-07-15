open_project -project {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER_fp\IGL2_FIR_FILTER.pro}\
         -connect_programmers {FALSE}
if { [catch {load_programming_data \
    -name {M2S010} \
    -fpga {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.map} \
    -header {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.hdr} \
    -spm {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.spm} \
    -dca {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.dca} } return_val] } {
    save_project
    close_project
    exit }
if { [catch {export_single_ppd \
    -name {M2S010} \
    -file {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER_new _50_sw\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER.ppd}} return_val ] } {
    save_project
    close_project
    exit}

set_programming_file -name {M2S010} -no_file
save_project
close_project
