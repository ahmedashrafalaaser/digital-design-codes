module fsm(clk,rst,d,q,ch,dis);
input clk,rst,d,q;
output ch,dis;
parameter q_25=2'b01;
 parameter q_50=2'b11 ;
 parameter w=2'b00; 
 reg [1:0] cs,ns;
 always @(posedge clk or negedge rst) begin
 	if (~rst) begin
 		// reset
 		cs<=w;
 	end
 	else  begin
 		cs<=ns;
 	end
 end
 always @(d,q,cs) begin
 	case (cs)
 	w: if(q)
 	ns=q_25;
 		else
 		ns=w;
 	q_25: if(q)
 	ns=q_50;
 	else
 	ns=q_25;
 	q_50: if(q)
 	ns=w;
 	else
 	ns=q_50;
 	endcase	
 end
 assign ch =(d&&cs==w)?1'b1:1'b0 ;
 assign dis =(d&&cs==w)?1'b1:(q&&cs==q_50)?1'b1:1'b0 ;
endmodule

module fsm_tb();
reg clk,rst,d,q;
wire ch,dis;
fsm dut(clk,rst,d,q,ch,dis);
initial begin
	clk=0;
	forever
	#2 clk=~clk;
end
initial begin
rst=0;
d=0;
q=0;
#10
rst=1;
#10
d=1;
q=0;
#10
d=0;
#10
q=1;
#4
q=0;
#2
q=1;
#4 q=0;
#10
q=1;
#4
q=0;
#2;
$stop;
end
endmodule