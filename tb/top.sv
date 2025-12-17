`timescale 1ns/1ps

`include "uvm_macros.svh"

import uvm_pkg::*;
import mux_pkg::*;

module top(); 
   
 logic clk;


 initial begin
    clk = 0;
    forever #5 clk = ~clk;
 end


 mux_if vif(clk);

 mux dut( .a(vif.a), .b(vif.b), .c(vif.c), .d(vif.d), .sel(vif.sel), .y(vif.y));

 initial begin
    uvm_config_db#(virtual mux_if)::set(null, "*", "vif", vif);
    run_test();
 end


endmodule



