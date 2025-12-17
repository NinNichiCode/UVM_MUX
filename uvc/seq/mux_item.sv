class mux_item extends uvm_sequence_item;

  rand bit [3:0] a, b, c, d;
  rand bit [1:0] sel;
  bit [3:0] y;

  `uvm_object_utils_begin(mux_item)
    `uvm_field_int(a, UVM_DEFAULT);
    `uvm_field_int(b, UVM_DEFAULT);
    `uvm_field_int(c, UVM_DEFAULT);
    `uvm_field_int(d, UVM_DEFAULT);
    `uvm_field_int(sel, UVM_DEFAULT);
    `uvm_field_int(y, UVM_DEFAULT);
  `uvm_object_utils_end
  function new(string name = "mux_item");
     super.new(name);
  endfunction

endclass
