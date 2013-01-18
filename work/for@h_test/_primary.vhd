library verilog;
use verilog.vl_types.all;
entity forH_test is
    generic(
        out_w           : integer := 64
    );
    port(
        BODY_DATA       : in     vl_logic_vector;
        TST             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of out_w : constant is 1;
end forH_test;
