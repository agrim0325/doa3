quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "D:/G5_SOC/DSP/FIR_FILTER/DSP_FIR_FILTER"
source "${PROJECT_DIR}/simulation/CM3_compile_bfm.tcl";

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v12.1/Designer/lib/modelsimpro/precompiled/vlog/SmartFusion2"
if {[file exists COREFFT_LIB/_info]} {
   echo "INFO: Simulation library COREFFT_LIB already exists"
} else {
   file delete -force COREFFT_LIB 
   vlib COREFFT_LIB
}
vmap COREFFT_LIB "COREFFT_LIB"
if {[file exists COREFIR_LIB/_info]} {
   echo "INFO: Simulation library COREFIR_LIB already exists"
} else {
   file delete -force COREFIR_LIB 
   vlib COREFIR_LIB
}
vmap COREFIR_LIB "COREFIR_LIB"
if {[file exists CORESYSSERVICES_LIB/_info]} {
   echo "INFO: Simulation library CORESYSSERVICES_LIB already exists"
} else {
   file delete -force CORESYSSERVICES_LIB 
   vlib CORESYSSERVICES_LIB
}
vmap CORESYSSERVICES_LIB "CORESYSSERVICES_LIB"

vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/PB_logic.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/crc_256_pwr.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/led_blink.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/CRC/CRC.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FCCC_C0/FCCC_C0_0/FCCC_C0_FCCC_C0_0_FCCC.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FCCC_C0/FCCC_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/COREUART_0/rtl/vlog/core_obfuscated/Clock_gen.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/COREUART_0/rtl/vlog/core_obfuscated/Rx_async.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/COREUART_0/rtl/vlog/core_obfuscated/Tx_async.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/COREUART_0/rtl/vlog/core_obfuscated/fifo_256x8_g4.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/COREUART_0/rtl/vlog/core_obfuscated/CoreUART.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/UART_IF.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/DATA_HANDLE/DATA_HANDLE.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/FILTER_CONTROL_FSM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/Coef_Buff/FIR_FILTER_Coef_Buff_TPSRAM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/FFT_Im_Buff/FIR_FILTER_FFT_Im_Buff_TPSRAM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/FFT_Re_Buff/FIR_FILTER_FFT_Re_Buff_TPSRAM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/FIR_IN_Buff/FIR_FILTER_FIR_IN_Buff_TPSRAM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/FIR_Out_Buff/FIR_FILTER_FIR_Out_Buff_TPSRAM.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFFT_0/rtl/in_place/vlog/core/FIR_FILTER_COREFFT_0_ram_smGen.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/7.0.104/rtl/in_place/vlog/core/kit.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFFT_0/rtl/in_place/vlog/core/fftDp.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFFT_0/twiddle32.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/7.0.104/rtl/in_place/vlog/core/mac_lib.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/7.0.104/rtl/in_place/vlog/core/cmplx.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/7.0.104/rtl/in_place/vlog/core/fftSm.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFFT_0/rtl/in_place/vlog/core/COREFFT.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFFT_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFFT_0/rtl/in_place/vlog/core/COREFFT_TOP.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4/mac_lib.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4/mac.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFIR/8.6.101/rtl/vlog/core/kit.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4/coef_store.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4/enum_fir.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4/enum_COREFIR.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work COREFIR_LIB "${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/top/COREFIR.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FIR_FILTER/FIR_FILTER.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/Actel/DirectCore/CoreResetP/8.0.103/rtl/vlog/core/coreresetp_pcie_hotreset.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/Actel/DirectCore/CoreResetP/8.0.103/rtl/vlog/core/coreresetp.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB/CCC_0/FlashFreeze_SB_CCC_0_FCCC.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB_MSS/FlashFreeze_SB_MSS.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB/FlashFreeze_SB.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0_0/OSC_C0_OSC_C0_0_OSC.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/TOP/TOP.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1/RESET_GEN.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/RESET_GEN_C0/RESET_GEN_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/work/FIR_FILTER/COREFIR_0/rtl/vlog/core/enum_SmFu4" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/test/test.v"

vsim -L SmartFusion2 -L presynth -L COREFFT_LIB -L COREFIR_LIB -L CORESYSSERVICES_LIB  -t 1fs presynth.test
add wave /test/*
run 1000ns
