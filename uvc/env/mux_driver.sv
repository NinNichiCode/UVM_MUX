class mux_driver extends uvm_driver #(mux_item);
   `uvm_component_utils(mux_driver)
   
   function new (string name = "mux_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   mux_item trans;
   virtual mux_if vif; 
   virtual function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      
//      trans = mux_item::type_id::create("trans", this);

      if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
         `uvm_fatal("DRV", "cannot access interface");
    endfunction

    virtual task run_phase (uvm_phase phase);
       forever begin 
         @(posedge vif.clk);
 
           seq_item_port.get_next_item(trans);
	    vif.sel <= trans.sel;
	    vif.a <= trans.a;
	    vif.b <= trans.b;
	    vif.c <= trans.c;
	    vif.d <= trans.d;
      `uvm_info("DRV", $sformatf("a:%0d  b:%0d c:%0d d:%0d sel:%0d y:%0d", trans.a, trans.b,trans.c,trans.d,trans.sel,trans.y), UVM_NONE);
       seq_item_port.item_done();
         end
    endtask

    endclass


