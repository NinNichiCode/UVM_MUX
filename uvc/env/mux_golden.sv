class mux_golden extends uvm_monitor;
   `uvm_component_utils(mux_golden);

    uvm_analysis_port #(mux_item) item_golden_port;
    virtual mux_if vif;
    mux_item trans;

   function new (string name = "", uvm_component parent = null);
      super.new(name, parent);
      item_golden_port = new("item_golden_port", this);
   endfunction

   virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
      
     if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
        `uvm_fatal("MON", "cannot access interface")
   endfunction

   function void predict();
       
          case (trans.sel) 
	     2'b00: trans.y = trans.a;
	     2'b01: trans.y = trans.b;
	     2'b10: trans.y = trans.c;
	     2'b11: trans.y = trans.d;
	    // default: trans.y = 4'b0000;
	  endcase
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
	     // trans.y <= vif.y;

	      predict();
	     
	    item_golden_port.write(trans); 
	 end
     endtask

 endclass




