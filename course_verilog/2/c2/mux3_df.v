module mux3_df(D0,D1,D2,S0,S1,Out);

parameter W=1;
input [W-1:0] D0,D1,D2;
input S0,S1;
output  reg [W-1:0]Out;


always @(*) begin
	if (!S1&&!S0)
	Out=D0;
	else if(!S1&&S0)
	Out=D1;
	else
	Out=D2;	
end

 endmodule


module mux_tb();
parameter X=5;
reg [X-1:0] D0,D1,D2;
reg S0,S1;
wire [X-1:0]Out1,Out2;
mux3 #(.W(X)) m1(D0,D1,D2,S0,S1,Out1);
mux3_df #(.W(X)) m2(D0,D1,D2,S0,S1,Out2);

integer i =0;
//integer t=1;
//assign X=t;
initial begin

for(i=0;i<10;i=i+1)begin
	//t=$random;
	
	D0=$random;
	D1=$random;
	D2=$random;
	S0=$random;
	S1=$random;
#10
if(Out1!=Out2)begin
	$display("error");
$stop;
end
end
$stop;


end

endmodule