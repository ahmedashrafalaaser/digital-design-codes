module Q1_LAT(gate,aclr,aset,data,q);
parameter LAT_WIDTH=1;
input gate/*work as a clk*/,aclr,aset;
input [LAT_WIDTH-1:0]data;
output reg [LAT_WIDTH-1:0]q;
always @(*) begin
if (aclr) begin
q<=0;
end
else if (aset) begin
q<={LAT_WIDTH{1'b1}};
end
else if(gate) begin
q<=data;
end
end
endmodule
module Q1_LAT_tb();
parameter LAT_WIDTH=7;
reg gate,aclr,aset;
reg [LAT_WIDTH-1:0]data;
wire [LAT_WIDTH-1:0]q;
integer i=0;
Q1_LAT #(LAT_WIDTH) dut(gate,aclr,aset,data,q);
initial begin
gate<=0;
forever
#30 gate<=~gate;
end
initial begin
aclr=1;
data=0;
aset=0;
#10 aclr=0;
for (i=0;i<100;i=i+1)begin
#1
data=$random;
end
#10
for (i=0;i<100;i=i+1)begin
#1
data=$random;
aclr=$random;
aset=$random;
end
#100;
$stop;
end
endmodule