
LIB = workA

TB_DIR = ../tb
UVC_DIR = ../uvc
RTL_DIR = ../

INCDIRS = +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/seq +incdir+$(UVC_DIR)/tests 

TESTS = mux_test

all: compile regress summary 

compile: 
	@echo "Compiling design files..."
	vlib $(LIB)  
	vmap work $(LIB) 
	vlog -work work -sv $(TB_DIR)/mux_if.sv $(RTL_DIR)/mux.v  
	vlog -work work -sv $(INCDIRS) $(UVC_DIR)/env/mux_pkg.sv 
	vlog -work work -sv $(TB_DIR)/top.sv

regress:
	@echo "Running simulation..."
	mkdir -p logs
	@for t in $(TESTS); do \
	vsim -c top +UVM_TESTNAME=$$t -l logs/$$t.log -do "run -all; quit -f"; \
	done

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
	rm -rm $(LIB) transcript logs *.log modelsim.ini

.PHONY: all compile regress summary clean

