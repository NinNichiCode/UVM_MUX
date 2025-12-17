class mux_test extends base_test;
  `uvm_component_utils(mux_test)

  function new(string name = "", uvm_component parent = null);
     super.new(name, parent);
  endfunction


  virtual task run_test_seq();
     mux_seq seq;
     seq = mux_seq::type_id::create("seq");
     seq.start(env.agent.seqr);
  endtask

endclass

