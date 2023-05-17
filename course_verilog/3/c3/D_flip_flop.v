module D_flip_flop(D,E,PRE,CLK,Q);
input D,E,PRE,CLK;
output reg Q;
always @(posedge CLK or negedge PRE ) begin
 	if (~PRE) begin
 		// PRE
 		Q<=1;
 	end
 	else  begin
 		if (E) begin
 			Q<=D;
 		end
 	end
 end 


endmodule

module D_flip_flop_tb();
reg D,E,PRE,CLK;
wire Q;
integer i=0;


D_flip_flop dut(D,E,PRE,CLK,Q);
initial begin
	CLK=0;
	forever
	#8 CLK=~CLK;
end
initial
begin
#3
//PRE=1;

	PRE=0;
	#10
	PRE=1;
	D=0;
	E=0;
	for(i=0;i<50;i=i+1)begin
	E=$random;
	@(negedge CLK);
	D=$random;
	end
	#10
	$stop;
	end
	endmodule



