module mem3wide(ADDR, IDATA, ODATA, CLK, RD, WR);
  parameter addr_w = 8;
  parameter data_w = 8;
  parameter words_count = 256;
  input RD;
  input WR;
  input CLK;
  input [addr_w-1:0] ADDR;
  output reg [data_w*3-1:0] ODATA;
  input [data_w-1:0] IDATA;
  reg [data_w-1:0] mem[words_count-1:0];
  integer file;
  integer return_value;
  initial begin
    file = $fopen("d:/Work/dissertation_microprocessor/altera_projects/filter/lol.bin", "r");
    return_value = $fread( mem, file); 
  end
  always @(posedge CLK) begin
    if(WR == 1) begin
        mem[ADDR] = IDATA[data_w - 1:0];
    end 
    if(ADDR < words_count - 3 + 1 && RD == 1) begin
        ODATA[data_w - 1:0] = mem[ADDR];
        ODATA[2*data_w - 1:data_w] = mem[ADDR+1];
        ODATA[3*data_w - 1:2*data_w] = mem[ADDR+2];
    end  
  end
endmodule

module mem3wide_o(ADDR, IDATA, ODATA, CLK, RD, WR);
  parameter addr_w = 8;
  parameter data_w = 8;
  parameter words_count = 256;
  input RD;
  input WR;
  input CLK;
  input [addr_w-1:0] ADDR;
  output reg [data_w*3-1:0] ODATA;
  input [data_w-1:0] IDATA;
  reg [data_w-1:0] mem[words_count-1:0];
  integer file;
  integer return_value;
  initial begin
    file = $fopen("d:/Work/dissertation_microprocessor/altera_projects/filter/lol.bin", "r");
    return_value = $fread( mem, file); 
    $fclose(file);
  end
  always @(posedge CLK) begin
    if(WR == 1) begin
        mem[ADDR] = IDATA[data_w - 1:0];
    end 
    if(ADDR < words_count - 3 + 1 && RD == 1) begin
        ODATA[data_w - 1:0] = mem[ADDR];
        ODATA[2*data_w - 1:data_w] = mem[ADDR+1];
        ODATA[3*data_w - 1:2*data_w] = mem[ADDR+2];
    end
    file = $fopen("d:/Work/dissertation_microprocessor/altera_projects/filter/out.bin", "w");
    $fwriteb(file, "%p", mem);
    $fclose(file);
  end
endmodule