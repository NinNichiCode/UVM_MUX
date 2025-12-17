class mux_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(mux_scoreboard)

   mux_item tr, tr_golden;

   uvm_tlm_analysis_fifo#(mux_item) item_got_imp;
   uvm_tlm_analysis_fifo#(mux_item) item_golden_imp;

   function new(string name, uvm_component parent = null);
     super.new(name, parent);
     item_got_imp = new("item_got_imp", this);
     item_golden_imp = new("item_golden_imp", this);
  endfunction

  function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     tr = mux_item::type_id::create("tr", this);
     tr_golden = mux_item::type_id::create("tr_golden", this);
   endfunction


   virtual task run_phase (uvm_phase phase);
     forever begin      
      item_got_imp.get(tr);
      item_golden_imp.get(tr_golden);

      if(tr.compare(tr_golden)) begin
	 `uvm_info("SB", $sformatf(" Passed | sel = %0h, y = %0h >< sel_gol = %0h, y_gol = %0h", tr.sel, tr.y, tr_golden.sel, tr_golden.y), UVM_LOW)
      end else begin 
	 `uvm_error("SB", $sformatf(" Failed | sel = %0h, y = %0h >< sel_gol = %0h, y_gol = %0h", tr.sel, tr.y, tr_golden.sel, tr_golden.y))
      end
     end 
  endtask

endclass

 
