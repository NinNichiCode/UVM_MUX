class mux_env extends uvm_env;
  `uvm_component_utils(mux_env)

  function new (string name = "mux_env", uvm_component parent = null);
     super.new(name, parent);
  endfunction

  mux_agent agent;
  mux_scoreboard scoreboard;
  mux_coverage cov;

  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     agent = mux_agent::type_id::create("agent", this);
     scoreboard = mux_scoreboard::type_id::create("scoreboard", this);
     cov = mux_coverage::type_id::create("cov", this);
   
   endfunction


  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agent.monitor.item_send_port.connect(scoreboard.item_got_imp.analysis_export);
     agent.golden.item_golden_port.connect(scoreboard.item_golden_imp.analysis_export);
     agent.monitor.item_send_port.connect(cov.analysis_export);
  endfunction

endclass


