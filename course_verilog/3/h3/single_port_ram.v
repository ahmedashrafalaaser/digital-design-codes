module Q3_RAM(clk,rst,blk_select,wr_en,rd_en,addr_en,dout_en,addr,din,parity_out,dout);
    parameter mem_width=16;
    parameter mem_depth=1024;
    parameter addr_size=10;
    parameter addr_pipline="TRUE";
    parameter dout_pipline="FALSE";
    parameter parity_enable=1;
   
    input clk,rst,blk_select,wr_en,rd_en,addr_en,dout_en;
    input[ addr_size-1:0]addr;
    input [mem_width-1:0]din;
    output reg parity_out;
    output reg [ mem_width-1:0]dout;
    wire [ addr_size-1:0]addr_pip;
    reg [ addr_size-1:0]addr_m;
    wire [mem_width-1:0]dout_M,dout_pip;
    wire par_out;
    mem #(.mem_width(mem_width),.mem_depth(mem_depth),.add_size(addr_size)) m1(clk,rst,blk_select,wr_en,addr_m,din,rd_en,dout_M,par_out);
    D_FlIP_FLOP #(addr_size) ad(addr,addr_en,clk,addr_pip);
    D_FlIP_FLOP #(mem_width) out(dout_M, dout_en ,clk, dout_pip);
    always @(posedge clk ) begin
        if (rst) begin
            // reset
  
            dout<=0;
            parity_out<=0;
        end
        else begin
        
            if (addr_pipline=="TRUE")
                addr_m<=addr_pip;
            else 
                addr_m<=addr;
            if (dout_pipline=="FALSE")
                dout<=dout_M;
            else
                dout<=dout_pip;
            if(parity_enable)
                parity_out<=par_out;
            else
                parity_out<=0;
        end
    end



endmodule
module D_FlIP_FLOP(d,e,clk,q);
    parameter N=1;
    input e,clk;
    input [N-1:0]d;
    output reg [N-1:0]q;
    always @(posedge clk ) begin
        if (e)
            q<=d;
    end
endmodule
module mem (clk,rst,blk_slect,wr_en,addr,din,rd_en,dout,par_out);
    parameter mem_width=16;
    parameter mem_depth=1024;
    parameter add_size=10;
    input clk,rst,blk_slect,wr_en,rd_en;
    input [add_size-1:0]addr;
    input [mem_width-1:0]din;
    output reg [mem_width-1:0]dout;
    output reg par_out;
    reg [mem_width-1:0]mem[mem_depth-1:0];

    always @(posedge clk ) begin
        if (rst) begin
            // reset
            dout<=0;
            par_out<=0;
        end
        else if (blk_slect) begin
            if(wr_en)
                mem[addr]<=din;
            else if(rd_en)begin
                dout<=mem[addr];
                par_out<=^mem[addr];
            end
        end
    end
endmodule

module Q3_RAM_tb();

reg clk,rst,blk_select,wr_en,rd_en,addr_en,dout_en;
   
    parameter mem_width=16;
    parameter mem_depth=1024;
    parameter addr_size=10;
    parameter addr_pipline="TRUE";
    parameter dout_pipline="FALSE";
    parameter parity_enable=1;

    reg[ addr_size-1:0]addr;
    reg [mem_width-1:0]din;
    wire parity_out;
    wire [ mem_width-1:0]dout;
   
Q3_RAM #(.mem_width(mem_width),.mem_depth(mem_depth),.addr_size(addr_size),.addr_pipline(addr_pipline),.dout_pipline(dout_pipline),.parity_enable(parity_enable))
 dut(clk,rst,blk_select,wr_en,rd_en,addr_en,dout_en,addr,din,parity_out,dout);
initial begin
clk=0;
forever
#2 clk=~clk;
end
integer i=0; 
initial begin
$readmemh("mem.dat",dut.m1.mem);
rst =1;
blk_select=0;
rd_en=0;
addr_en=0;
wr_en=0;
dout_en=0;
addr=0;
din=0;
#10 
rst=0;
rd_en=0;
for(i=0;i<5000;i=i+1)begin
@ (negedge clk);
addr_en=$random;
blk_select=$random;
addr=$random;
din=$random;
wr_en=$random;
end
#10 
wr_en=0;
for(i=0;i<5000;i=i+1)begin
@ (negedge clk);
addr_en=$random;
blk_select=$random;
addr=$random;
din=$random;
rd_en=$random;
end
#10;
for(i=0;i<5000;i=i+1)begin
@ (negedge clk);
addr_en=$random;
blk_select=$random;
addr=$random;
din=$random;
rd_en=$random;
wr_en=~rd_en;
end
#10 
$stop;
end 

endmodule