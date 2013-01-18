module filter_tb();
  reg rCLK;
  wire CLK;
  assign CLK = rCLK;
  reg rRST;
  wire RST;
  assign RST = rRST;
  reg rRD;
  wire RD;
  assign RD = rRD;
  reg rST;
  wire ST;
  assign ST = rST;
  
  filter f(RST, CLK, ST, RD);
  
  initial begin
    rCLK = 0;
    #10 rRST = 1;
    #10 rRST = 0;
    #10 rST = 1; 
    #10 rST = 0; 
  end
  
  always begin
    #5 rCLK = ~rCLK;
  end
  
endmodule