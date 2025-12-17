class mux_monitor extends uvm_monitor;
   `uvm_component_utils(mux_monitor);

    uvm_analysis_port #(mux_item) item_send_port;
    virtual mux_if vif;
    mux_item trans;

   function new (string name = "", uvm_component parent = null);
      super.new(name, parent);
      item_send_port = new("item_send_port", this);
   endfunction

   virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
      
     if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
        `uvm_fatal("MON", "cannot access interface")
   endfunction

   virtual task run_phase (uvm_phase phase);
      forever begin 
         @(posedge vif.clk);
	    trans = mux_item::type_id::create("trans", this);

	      trans.sel = vif.sel;
	      trans.a = vif.a;
	      trans.b = vif.b;
	      trans.c = vif.c;
	      trans.d = vif.d;
	      trans.y = vif.y;
`uvm_info("MON", $sformatf("Sent: sel=%0h a=%0h b=%0h c=%0h d=%0h y=%0h", trans.sel, trans.a, trans.b, trans.c, trans.d, trans.y), UVM_MEDIUM)               
	       item_send_port.write(trans);
        end
     endtask

 endclass




