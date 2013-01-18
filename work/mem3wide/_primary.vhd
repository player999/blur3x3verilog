library verilog;
use verilog.vl_types.all;
entity mem3wide is
    generic(
        addr_w          : integer := 8;
        data_w          : integer := 8;
        words_count     : integer := 256
    );
    port(
        ADDR            : in     vl_logic_vector;
        IDATA           : in     vl_logic_vector;
        ODATA           : out    vl_logic_vector;
        CLK             : in     vl_logic;
        RD              : in     vl_logic;
        WR              : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of addr_w : constant is 1;
    attribute mti_svvh_generic_type of data_w : constant is 1;
    attribute mti_svvh_generic_type of words_count : constant is 1;
end mem3wide;
