class mux_seq extends uvm_sequence#(mux_item);
   `uvm_object_utils(mux_seq);

   function new (string name = "");
      super.new(name);
   endfunction

  
   mux_item req;
   virtual task body();
      
   //   mux_item req;
      req = mux_item::type_id::create("req");

      repeat(10) begin

      `uvm_do(req)

//      start_item(req); 
 //       req.sel = 2'b01;
 //     finish_item(req);
     end
   endtask

endclass

