`timescale 1ns/1ps
interface mux_if(input bit clk);
  logic [3:0] a;
  logic [3:0] b;
  logic [3:0] c;
  logic [3:0] d;
  logic [1:0] sel;
  logic [3:0] y;
  
  clocking drv_cb @(posedge clk);
     default input #1step output #1ns;
     output a;
     output b;
     output c;
     output d;
     output sel;
  endclocking

  clocking mon_cb @(posedge clk);
     default input #1step output #1ns;
     input a;
     input b;
     input c;
     input d;
     input sel;
     input y;
  endclocking

endinterface
