package mux_pkg;

  import uvm_pkg::*;
`include "uvm_macros.svh"

  `include "../seq/mux_item.sv";
  `include "mux_driver.sv";
  `include "mux_monitor.sv";
  `include "mux_golden.sv";
  `include "mux_scoreboard.sv";
  `include "mux_coverage.sv";
  `include "mux_agent.sv";
  `include "mux_env.sv";
  
  `include "../seq/mux_seq.sv";
  `include "../tests/base_test.sv";
  `include "../tests/mux_test.sv";

endpackage
