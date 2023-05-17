  module mem (clk,rst,blk_slect,wr_en,addr_wr,din,rd_en,addr_rd,dout);
  parameter mem_width=16;
  parameter mem_depth=1024;
  parameter add_size=10;
  input clk,rst,blk_slect,wr_en,rd_en;
  input [add_size-1:0]addr_wr,addr_rd;
  input [mem_width-1:0]din;
  output reg [mem_width-1:0]dout;
  reg [mem_width-1:0]mem[mem_width-1:0];

  always @(posedge clk ) begin
      if (rst) begin
          // reset
          dout<=0;
      end
      else if (blk_slect) begin
        if(wr_en)
          mem[addr_wr]<=din;
        if(rd_en)
          dout<=mem[addr_rd];
      end
  end
  endmodule