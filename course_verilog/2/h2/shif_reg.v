module Q4_SR(sclr,sset,shiftin,load,data,clock,enable,aclr,aset,shiftout,q);
parameter LOAD_AVALUE =7;
parameter SHIFT_DIRICTION ="LEFT";
parameter LOAD_SVALUE =3;
parameter SHIFT_WIDTH =4;
input sclr,sset,shiftin,load,clock,enable,aclr,aset;
input [SHIFT_WIDTH-1:0]data;
output reg shiftout;
output reg [SHIFT_WIDTH-1:0]q;
always @(posedge clock or posedge aclr or posedge aset) begin
if (aclr) begin
shiftout=0;
q=0;
end
else if (aset) begin
q=LOAD_AVALUE;
end
else if (enable) begin
if(sclr) begin
q=0;
end
else if (sset) begin
q=LOAD_SVALUE;
end
else if (load) begin
q=data;
end
else if (SHIFT_DIRICTION=="RIGHT") begin
shiftout<=q[0];
q<={shiftin,q[SHIFT_WIDTH-1:1]};
end
else begin
shiftout<=q[SHIFT_WIDTH-1];
q<={q[SHIFT_WIDTH-2:0],shiftin};
end
end
end
endmodule
module Q4_SR_tb();
parameter LOAD_AVALUE =7;
parameter SHIFT_DIRICTION ="RIGHT";
parameter LOAD_SVALUE =3;
parameter SHIFT_WIDTH =4;
reg sclr,sset,shiftin,load,clock,enable,aclr,aset;
reg [SHIFT_WIDTH-1:0]data;
wire shiftout;
wire [SHIFT_WIDTH-1:0]q;
Q4_SR #(.SHIFT_DIRICTION(SHIFT_DIRICTION),.LOAD_AVALUE(LOAD_AVALUE),.LOAD_SVALUE(LOAD_SVALUE),.SHIFT_WIDTH(SHIFT_WIDTH)) dut (sclr,sset,shiftin,load,data,clock,enable,aclr,aset,shiftout,q);
integer i=0;
initial begin
clock=0;
forever
#2 clock=~clock;
end
initial begin
sclr=0;
sset=0;
shiftin=0;
load=0;
enable=0;
aclr=0;
aset=0;
data=0;
#10
aclr=1;
#5
aclr=0;
aset=1;
#10
aset=0;
#5;
for (i=0;i<20;i=i+1)begin
@(negedge clock);
sclr=$random;
sset=$random;
shiftin=$random;
load=$random;
enable=$random;
data=$random;
end
#5sclr=0;
sset=0;
for (i=0;i<80;i=i+1)begin
@(negedge clock);
shiftin=$random;
load=$random;
enable=$random;
data=$random;
end
$stop;
end
endmodule