transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ardac/Documents/Arda/term2/embed/p1/project {C:/Users/ardac/Documents/Arda/term2/embed/p1/project/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/ardac/Documents/Arda/term2/embed/p1/project {C:/Users/ardac/Documents/Arda/term2/embed/p1/project/controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/ardac/Documents/Arda/term2/embed/p1/project {C:/Users/ardac/Documents/Arda/term2/embed/p1/project/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/ardac/Documents/Arda/term2/embed/p1/project {C:/Users/ardac/Documents/Arda/term2/embed/p1/project/train_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/ardac/Documents/Arda/term2/embed/p1/project {C:/Users/ardac/Documents/Arda/term2/embed/p1/project/test_bench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  test_bench

add wave *
view structure
view signals
run -all
