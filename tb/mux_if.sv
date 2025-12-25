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

  //---------------------------------------------------------
  // SVA 
  //---------------------------------------------------------
  default disable iff ($isunknown(sel));

  property p_sel_a;
    @(posedge clk) (sel == 2'b00) |-> (y == a);
  endproperty

  property p_sel_b;
    @(posedge clk) (sel == 2'b01) |-> (y == b);
  endproperty

  property p_sel_c;
    @(posedge clk) (sel == 2'b10) |-> (y == c);
  endproperty

  property p_sel_d;
    @(posedge clk) (sel == 2'b11) |-> (y == d);
  endproperty

  ASSERT_SEL_A: assert property (p_sel_a) else $error("MUX Error: sel=00 but y != a");
  ASSERT_SEL_B: assert property (p_sel_b) else $error("MUX Error: sel=01 but y != b");
  ASSERT_SEL_C: assert property (p_sel_c) else $error("MUX Error: sel=10 but y != c");
  ASSERT_SEL_D: assert property (p_sel_d) else $error("MUX Error: sel=11 but y != d");

  COVER_SEL_A: cover property (p_sel_a);
  COVER_SEL_B: cover property (p_sel_b);
  COVER_SEL_C: cover property (p_sel_c);
  COVER_SEL_D: cover property (p_sel_d);

endinterface
