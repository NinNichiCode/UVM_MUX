class mux_agent extends uvm_agent;
  `uvm_component_utils(mux_agent)

  function new(string name = "mux_agent", uvm_component parent = null);
    super.new(name, parent);
 endfunction

  mux_driver driver;
  mux_monitor monitor;
  mux_golden golden;
  uvm_sequencer #(mux_item) seqr;

  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     driver = mux_driver::type_id::create("driver", this);
     monitor = mux_monitor::type_id::create("monitor", this);
     golden = mux_golden::type_id::create("golden", this);
     seqr = uvm_sequencer#(mux_item)::type_id::create("seqr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     driver.seq_item_port.connect(seqr.seq_item_export);
  endfunction

  endclass

