onerror {quit -f}
vlib work
vlog -work work p8086.vo
vlog -work work p8086.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.p8086_vlg_vec_tst
vcd file -direction p8086.msim.vcd
vcd add -internal p8086_vlg_vec_tst/*
vcd add -internal p8086_vlg_vec_tst/i1/*
add wave /*
run -all
