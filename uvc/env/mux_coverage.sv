
// CP_SEL: 100% (Đã chọn đủ kênh).
// CP_DATA_PATTERNS: Đã thấy dữ liệu 0000, 1111, 1010 (5), 0101 (A) xuất hiện ở ngõ ra.
// CP_SEL_TRANS: Đã test chuyển đổi qua lại giữa các kênh.
// CROSS_DATA_FLOW: Chứng minh được y == a khi sel=0, y == b khi sel=1,... với các giá trị biên.


class mux_coverage extends uvm_subscriber #(mux_item);
   `uvm_component_utils(mux_coverage)
 
    mux_item trans;

    covergroup cov_inst;
        CP_SEL: coverpoint trans.sel ;

        CP_y: coverpoint trans.y {
            bins data_y[] = {4'h0, 4'hf, 4'ha, 4'h1};
            bins data_y_range[4] = {[4'h0:4'hf]};
        }

    CP_A : coverpoint trans.a { bins corners = {4'h0, 4'hF, 4'hA, 4'h5}; }
    CP_B : coverpoint trans.b { bins corners = {4'h0, 4'hF, 4'hA, 4'h5}; }
    CP_C : coverpoint trans.c { bins corners = {4'h0, 4'hF, 4'hA, 4'h5}; }
    CP_D : coverpoint trans.d { bins corners = {4'h0, 4'hF, 4'hA, 4'h5}; }

    // Cross để đảm bảo dữ liệu biên đã đi qua từng cổng của MUX
    X_SEL_A : cross CP_SEL, CP_A {
        bins a_passed = binsof(CP_SEL) intersect {2'b00} && binsof(CP_A.corners);
    }
    X_SEL_B : cross CP_SEL, CP_B {
        bins b_passed = binsof(CP_SEL) intersect {2'b01} && binsof(CP_B.corners);
    }

    X_SEL_C : cross CP_SEL, CP_C {
        bins c_passed = binsof(CP_SEL) intersect {2'b10} && binsof(CP_C.corners);
    }
    X_SEL_D : cross CP_SEL, CP_D {
        bins d_passed = binsof(CP_SEL) intersect {2'b11} && binsof(CP_D.corners);
    }

    CP_SEL_TRANS : coverpoint trans.sel {
        bins switch_all[] = (0, 1, 2, 3 => 0, 1, 2, 3); 
        // Bin này sẽ đo mọi cặp chuyển đổi: 0->1, 0->2, 1->3, 3->0, v.v.
    }

    endgroup

    function new(string name = "mux_coverage", uvm_component parent = null);
        super.new(name, parent);
        cov_inst = new();
    endfunction

    virtual function void write(mux_item t);
        trans = t;
        cov_inst.sample();
    endfunction
endclass
