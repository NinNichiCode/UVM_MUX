
LIB = workA

TB_DIR = ../tb
UVC_DIR = ../uvc
RTL_DIR = ../

INCDIRS = +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/seq +incdir+$(UVC_DIR)/tests 

TESTS = mux_test

all: compile regress coverage summary 

compile: 
	@echo "Compiling design files..."
	vlib $(LIB)  
	vmap work $(LIB) 
	vlog -work work -sv -cover bcetf $(TB_DIR)/mux_if.sv $(RTL_DIR)/mux.v  
	vlog -work work -sv -cover bcetf $(INCDIRS) $(UVC_DIR)/env/mux_pkg.sv 
	vlog -work work -sv -cover bcetf $(TB_DIR)/top.sv

regress:
	@echo "Running simulation..."
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t \
	-voptargs="+acc" \
	-l logs/$$t.log -do "coverage save -onexit cov/$$t.ucdb; run -all; quit";  \
	done

coverage:
	@echo "Generating coverage reports..."
	vcover report -html cov/mux_test.ucdb -htmldir cov/html
	vcover report -details -file cov/coverage.txt cov/mux_test.ucdb


summary: 
	@echo "Generating summary report..."
	@echo "Simulation completed. Check logs for details."
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed 's#.*/##'

clean:
	@echo "Cleaning up..."
	rm -rf $(LIB) transcript logs cov *.log modelsim.ini 

.PHONY: all compile regress coverage summary clean
