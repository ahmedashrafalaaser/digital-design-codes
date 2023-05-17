module Q5_1_COUNTER(set,clk,out);
input clk,set;
output reg [3:0]out;
always @(posedge clk or negedge set) begin
if (~set) begin
out=4'b1111;
end
else begin
out=out+4'd1;
end
end
endmodule
/******************2****************/
module Q5_2_D_FLIP_FLOP(d,rstn,clk,q,qbar);
input d,rstn,clk;
output reg q,qbar;
always @(posedge clk or negedge rstn) begin
if (~rstn) begin
q=0;
end
else begin
q=d;
end
qbar=!q;
end
endmodule
/*****************3**************/
module Q5_3_COUNTER(rstn,clk,out);
input clk,rstn;
output [3:0]out;
wire q1,q2,q0,q3;
Q5_2_D_FLIP_FLOP dff1(out[0],rstn,clk,q0,out[0]);
Q5_2_D_FLIP_FLOP dff2(out[1],rstn,q0,q1,out[1]);
Q5_2_D_FLIP_FLOP dff3(out[2],rstn,q1,q2,out[2]);
Q5_2_D_FLIP_FLOP dff4(out[3],rstn,q2,q3,out[3]);
endmodule
/***************4****************/
module Q5_4_tb();
reg clk,rstn;
wire [3:0]out1,out2;
integer i=0;
Q5_3_COUNTER d1(rstn,clk,out1);
Q5_1_COUNTER d2(rstn,clk,out2);
initial begin
clk=0;
forever
#2 clk = ~clk;
end
initial begin
rstn=0;
#5
rstn=1;
for (i=0;i<1000;i=i+1)begin
@ (edge clk);
if(out2 != out1)
begin
$display("Error");
$stop;
end
end
$stop;
end
initial begin
$monitor("out1 = %d out2=%d",out1,out2);
end
endmodule