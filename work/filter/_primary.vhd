library verilog;
use verilog.vl_types.all;
entity filter is
    generic(
        imW             : integer := 16;
        imH             : integer := 16;
        idata_w         : integer := 24;
        odata_w         : integer := 8;
        addr_w          : integer := 8
    );
    port(
        RST             : in     vl_logic;
        CLK             : in     vl_logic;
        ST              : in     vl_logic;
        RD              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of imW : constant is 1;
    attribute mti_svvh_generic_type of imH : constant is 1;
    attribute mti_svvh_generic_type of idata_w : constant is 1;
    attribute mti_svvh_generic_type of odata_w : constant is 1;
    attribute mti_svvh_generic_type of addr_w : constant is 1;
end filter;
