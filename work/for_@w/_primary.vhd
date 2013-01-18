library verilog;
use verilog.vl_types.all;
entity for_W is
    generic(
        in_w            : integer := 64;
        out_w           : integer := 64;
        int_in_w        : integer := 64;
        int_out_w       : integer := 64
    );
    port(
        IN_DATA         : in     vl_logic_vector;
        OUT_DATA        : out    vl_logic_vector;
        RD              : out    vl_logic;
        ST              : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of in_w : constant is 1;
    attribute mti_svvh_generic_type of out_w : constant is 1;
    attribute mti_svvh_generic_type of int_in_w : constant is 1;
    attribute mti_svvh_generic_type of int_out_w : constant is 1;
end for_W;
