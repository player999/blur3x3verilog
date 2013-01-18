module filter(RST, CLK, ST, RD);
parameter imW = 16;
parameter imH = 16;
parameter idata_w = 8*3;
parameter odata_w = 8;
parameter addr_w = 8;

input CLK;
input ST;
input RST;
output reg RD;
reg [63:0] IN_DATA;
wire [63:0] OUT_DATA;
wire BR;
always @(posedge CLK) begin
 if(RST == 1) begin
  IN_DATA = 0;
 end 
 if(BR == 1) begin
  RD = 1;
 end
end
for_H main(IN_DATA, OUT_DATA, BR, ST, CLK, RST);
endmodule

module for_H(IN_DATA, OUT_DATA, RD, ST, CLK, RST);
parameter in_w = 64;
parameter out_w = 64;
parameter int_in_w = 64;
parameter int_out_w = 64;
input [in_w-1:0] IN_DATA;
output reg [out_w-1:0] OUT_DATA;
reg [out_w-1:0] DATA;
input CLK;
output reg RD;
input ST;
input RST;

reg [1:0] state;
reg BS;
wire TST;
wire TST1;
wire BR;
wire [in_w-1:0] INIT_DATA;
wire [out_w-1:0] BODY_DATA;

forH_init init_module(IN_DATA, INIT_DATA);
forH_body body_module(DATA, BODY_DATA, BR, BS, CLK, RST);
forH_test test_module(BODY_DATA, TST);
forH_test test_module1(INIT_DATA, TST1);
   always @(posedge CLK) begin
          if(RST == 1) begin
                 state = 0;
                 OUT_DATA = 0;
                 RD = 1;
          end

          case(state)
                  0: begin
                    BS = 0;
                    RD = 1;
                    if(ST == 1) begin
                      DATA = INIT_DATA;
                      state = 1;
                    end
                  end
                  1: begin
                    BS = 0;
                    RD = 0;
                    if(TST1 == 1) begin
                      state = 2;
                      BS = 1;
                    end else begin
                      state = 0;
                      OUT_DATA = INIT_DATA;
                    end                
                  end
                  2: begin
                    BS = 1;
                    RD = 0;
                    if(BR == 1) begin
                      state = 3;
                      DATA = BODY_DATA;
                    end
                  end
                  3: begin
                    BS = 0;
                    RD = 0;
                    if(TST == 1) begin
                      state = 2;
                      BS = 0;
                    end else begin
                      state = 0;
                      OUT_DATA = DATA;
                    end
                  end
                  default: begin
                     state = 0;
                  end
          endcase
   end
endmodule

module for_W(IN_DATA, OUT_DATA, RD, ST, CLK, RST);
parameter in_w = 64;
parameter out_w = 64;
parameter int_in_w = 64;
parameter int_out_w = 64;

input [in_w-1:0] IN_DATA;
output reg [out_w-1:0] OUT_DATA;
reg [out_w-1:0] DATA; 
input CLK;
output reg RD;
input ST;
input RST;

reg [1:0] state;
reg BS;
wire TST;
wire TST1;
wire BR;
wire [in_w-1:0] INIT_DATA;
wire [out_w-1:0] BODY_DATA;

forW_init init_module(IN_DATA, INIT_DATA);
forW_body body_module(DATA, BODY_DATA, BR, BS, CLK, RST);
forW_test test_module(BODY_DATA, TST);
forW_test test_module1(INIT_DATA, TST1);
   always @(posedge CLK) begin
          if(RST == 1) begin
                 state = 3;
                 DATA = 0;
                 RD = 1;
          end

          case(state)
                  0: begin
                    BS = 0;
                    RD = 1;
                    if(ST == 1) begin
                      DATA = INIT_DATA;
                      state = 1;
                    end
                  end
                  1: begin
                    BS = 0;
                    RD = 0;
                    if(TST1 == 1) begin
                      state = 2;
                      BS = 1;
                    end else begin
                      state = 0;
                      OUT_DATA = INIT_DATA;
                    end                
                  end
                  2: begin
                    BS = 1;
                    RD = 0;
                    if(BR == 1) begin
                      state = 3;
                      DATA = BODY_DATA;
                    end
                  end
                  3: begin
                    BS = 0;
                    RD = 0;
                    if(TST == 1) begin
                      state = 2;
                      BS = 0;
                    end else begin
                      state = 0;
                      OUT_DATA = DATA;
                    end
                  end
                  default: begin
                     state = 0;
                  end
          endcase
   end
endmodule

module forH_body(IN_DATA, OUT_DATA, RD, ST, CLK, RST);
  parameter in_w = 64;
  parameter out_w = 64;
  
  input [in_w-1:0] IN_DATA;
  output [out_w-1:0] OUT_DATA;
  input CLK;
  output RD;
  input ST;
  input RST;
  for_W inner(IN_DATA, OUT_DATA, RD, ST, CLK, RST); 
endmodule

module forH_init(IN_DATA, OUT_DATA);
  parameter in_w = 64;
  input [in_w-1:0] IN_DATA;
  output[in_w-1:0] OUT_DATA;
  assign OUT_DATA = IN_DATA;
endmodule

module forH_test(BODY_DATA, TST);
  parameter out_w = 64;
  input [out_w-1:0] BODY_DATA;
  output TST;
  assign TST = BODY_DATA[63:32] < 16-2;
endmodule

module forW_body(IN_DATA, OUT_DATA, RD, ST, CLK, RST);
  parameter in_w = 64;
  parameter out_w = 64;
  parameter addr_w = 8;
  parameter idata_w = 24;
  parameter imH = 16;
  parameter imW = 16;
  input [in_w-1:0] IN_DATA;
  output reg [out_w-1:0] OUT_DATA;
  input CLK;
  output reg RD;
  input ST;
  input RST;
  wire [addr_w-1:0] I;
  wire [addr_w-1:0] J;
  reg [addr_w-1:0] ADDR1;
  reg [addr_w-1:0] ADDR2;
  reg [addr_w-1:0] ADDR3;
  reg [addr_w-1:0] ADDRO;
  wire [idata_w-1:0] IDATA1;
  wire [idata_w-1:0] IDATA2;
  wire [idata_w-1:0] IDATA3;
  reg [7:0] PXDATA;
  wire [7:0] A0;
  wire [7:0] A1;
  wire [7:0] A2;
  wire [7:0] A3;
  wire [7:0] A4;
  wire [7:0] A5;
  wire [7:0] A6;
  wire [7:0] A7;
  wire [7:0] A8;
  wire [11:0] PIXEL;
  reg WR;
  reg Read;
  assign J = IN_DATA[7:0];
  assign I = IN_DATA[39:32];
  assign A0 = IDATA1[7:0];
  assign A1 = IDATA1[15:8];
  assign A2 = IDATA1[23:16];
  assign A3 = IDATA2[7:0];
  assign A4 = IDATA2[15:8];
  assign A5 = IDATA2[23:16];
  assign A6 = IDATA3[7:0];
  assign A7 = IDATA3[15:8];
  assign A8 = IDATA3[23:16];
  assign PIXEL = (A0 + A1 + A2 + A3 + A4 + A5 + A6 + A7 + A8) / 9;
  mem3wide mem1(ADDR1, 8'h0, IDATA1, CLK, Read, 1'b0);
  mem3wide mem2(ADDR2, 8'h0, IDATA2, CLK, Read, 1'b0);
  mem3wide mem3(ADDR3, 8'h0, IDATA3, CLK, Read, 1'b0);
  mem3wide_o memout(.ADDR(ADDRO), .IDATA(PXDATA), .CLK(CLK), .RD(1'b0), .WR(WR));
  always @(posedge CLK) begin
      if(RST == 1) begin 
        ADDR1 = 0 * imW;
        ADDR2 = 1 * imW;
        ADDR3 = 2 * imW;
        RD = 0;
        Read = 1;
      end
      if(ST == 1) begin
        RD = 0;
        Read = 1;
        ADDRO = I * imW + J - 1;
        ADDR2 = (I + 0)* imW + J - 2;
        ADDR3 = (I + 1) * imW + J - 2;
        ADDR1 = (I - 1) * imW + J - 2;
        
        WR = 0;
      end
      if(ST == 0 && RD == 0) begin 
        Read = 0;
        WR = 1;
        PXDATA = PIXEL[7:0];
        RD = 1;
      end
      OUT_DATA[31:0] = IN_DATA[31:0] + 1;
      OUT_DATA[63:32] = IN_DATA[63:32];
  end
  
endmodule

module forW_init(IN_DATA, OUT_DATA);
  parameter in_w = 64;
  input [in_w-1:0] IN_DATA;
  output[in_w-1:0] OUT_DATA;
  assign OUT_DATA[63:32] = IN_DATA[63:32] + 1;
  assign OUT_DATA[31:0] = 1;
endmodule

module forW_test(BODY_DATA, TST);
  parameter out_w = 64;
  input [out_w-1:0] BODY_DATA;
  output TST;
  assign TST = BODY_DATA[31:0] < 16-1;
endmodule