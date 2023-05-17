module Q2_D_FlIP_FLOP(d,e,clk,q);
parameter N=1;
input e,clk;
input [N-1:0]d;
output reg [N-1:0]q;
always @(posedge clk ) begin
if (e)
q<=d;
end
endmodule
module Q2_D_FlIP_FLOP_tb();
parameter N=1;
reg e,clk;
reg [N-1:0]d;
wire [N-1:0]q;
integer i=0;
Q2_D_FlIP_FLOP #(N) dut(d,e,clk,q);
initial begin
clk=0;
forever
#2 clk=~clk;
end
initial begin
d=0;
e=0;
#6;
for (i=0;i<100;i=i+1)begin
@(negedge clk);
d=$random;
end
#6
e=1;
for (i=0;i<100;i=i+1)begin
@(negedge clk);
d=$random;
end
#6;
for (i=0;i<100;i=i+1)begin
@(negedge clk);
d=$random;
e=$random;
end
$stop;
end
endmodule