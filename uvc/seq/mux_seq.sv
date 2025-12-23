class mux_seq extends uvm_sequence#(mux_item);
   `uvm_object_utils(mux_seq);

   function new (string name = "");
      super.new(name);
   endfunction

  
   mux_item req;
   virtual task body();
      
   //   mux_item req;
      req = mux_item::type_id::create("req");

      repeat(50) begin
      `uvm_do(req)
     end
       $display ("================ =================");
       repeat(5) begin
         `uvm_do_with (req, {
            sel == 2'b00;
         });
       end

       $display ("================ =================");
       repeat(5) begin
         `uvm_do_with (req, {
            sel == 2'b01;
         });
       end

        $display ("================ =================");
       repeat(5) begin
         `uvm_do_with (req, {
            sel == 2'b10;
         });
       end

      $display ("================ =================");

       repeat(5) begin
         `uvm_do_with (req, {
            sel == 2'b11;
            d == 4'hf;
         });
       end
   endtask

endclass

