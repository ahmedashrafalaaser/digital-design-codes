`timescale 1ns / 1ps
module Q1_FSM(x,clk,rst,y,count);
    input x,clk,rst;
    output reg y;
    output reg [9:0]count;
    reg [1:0]cs,ns;
    parameter A=2'b00;
    parameter B=2'b01;
    parameter C=2'b10;
    parameter D=2'b11;
    always @(posedge clk, posedge rst)begin
        if(rst)begin
            cs<=A;
            count<=0;
        end
        else
            cs<=ns;
    end
    always @(cs,x)begin
        case (cs)
            A:if(x)
                ns=B;
            else
                ns=A;
            B:if(x)
                ns=D;
            else
                ns=C;
            C:if(x)
                ns=B;
            else
                ns=A;
            D:if(x)
                ns=D;
            else
                ns=A;
            default:
            ns=A;
        endcase
    end
    always @(cs)begin
        case(cs)
            A:y=0;
            B:y=0;
            C:begin
                y=1;
                count=count+1;
            end
            D:y=0;
            default:begin
                y=0;
                count=0;
            end
        endcase
    end
endmodule

module Q1_FSM_tb();
    reg x,clk,rst;
    wire y;
    wire [9:0]count;
    integer i=0;
    Q1_FSM d1(x,clk,rst,y,count);
    initial begin
        clk=0;
        forever
            #10 clk=~clk;
    end
    initial begin
        rst=1;
        #5 rst=0;
        for(i=0;i<100;i=i+1)begin
            #10
            x=$random;
            if(i==50)
                rst=1;
            else
                rst=0;
        end
        $stop;
    end
endmodule

