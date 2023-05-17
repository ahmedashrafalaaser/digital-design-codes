module Q3_SLE(D,CLK,EN,ALn,ADn,SLn,SD,LAT,Q);
input D,CLK,EN,ALn,ADn,SLn,SD,LAT;
output reg Q;
reg in;
always @(posedge CLK ) begin
if (~ALn) begin
in=!ADn;
end
else if(EN) begin
if (~SLn) begin
in=SD;
end
else begin
in=D;
end
end
end
always @(*) begin
if (~LAT|| ~ALn) begin
Q=in;
end
else if(CLK) begin
if (EN) begin
if (~SLn) begin
Q=SD;
end
else
Q=D;
end
end
end
endmodule
module Q3_SLE_tb();
reg D,CLK,EN,ALn,ADn,SLn,SD,LAT;
wire Q;
integer i=0;
Q3_SLE dut(D,CLK,EN,ALn,ADn,SLn,SD,LAT,Q);
initial begin
CLK=0;
forever
#2 CLK=~CLK;
end
initial begin
D=0;
EN=0;
ALn=1;
ADn=1;
SLn =1;
SD=0;
LAT=1;
#2
ALn=0;
ADn=0;
for (i=0;i<20;i=i+1)begin
@(negedge CLK);
D=$random;
EN=$random;
ADn=$random;
SLn =$random;
SD=$random;
LAT=$random;
end
#4
ALn=1;
LAT=0;
for (i=0;i<10;i=i+1)begin
@(negedge CLK);
D=$random;
EN=$random;
ADn=$random;
SLn =$random;
SD=$random;
end
#4
ALn=1;
LAT=0;
EN=0;
for (i=0;i<10;i=i+1)begin
@(negedge CLK);
D=$random;
ADn=$random;
SLn =$random;
SD=$random;
end
#4
ALn=1;
LAT=0;
EN=1;
for (i=0;i<10;i=i+1)begin
@(negedge CLK);
D=$random;
ADn=$random;
SLn =$random;
SD=$random;
end
#4
ALn=1;
LAT=1;
for (i=0;i<10;i=i+1)begin
D=$random;
EN=$random;
ADn=$random;
SLn =$random;
SD=$random;
end
D=0;
EN=0;
ALn=0;
ADn=0;
SLn =1;
SD=0;
LAT=0;
#10;
$stop;
end
endmodule