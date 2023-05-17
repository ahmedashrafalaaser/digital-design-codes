

module shift(C,SI,Mode,PO);
input C, SI,Mode;
output reg[7:0]PO;
initial begin
PO=8'b0;
end
always @(posedge C ) begin
	if (Mode) begin
		// reset
		PO<={PO[6:0],SI};
	end
	else begin
		PO<={SI,PO[7:1]};
	end
end
endmodule