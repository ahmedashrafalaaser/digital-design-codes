
module Q2_FSM(speed_limit,car_speed,leading_distance,clk,rst,unlock_door,accelerate_car);
    input clk,rst;
    input [7:0]speed_limit,car_speed;
    input [6:0]leading_distance;
    output reg unlock_door,accelerate_car;
    parameter min_distance=7'd40;
    reg [1:0]cs,ns;
    parameter stop=2'b00;
    parameter accelerate=2'b01;
    parameter decelerate=2'b11;
    always @(posedge clk, posedge rst)begin
        if(rst)begin
            cs<=stop;
        end
        else
            cs<=ns;
    end
    always @(cs,speed_limit,car_speed,leading_distance)begin
        case (cs)
            stop:if(leading_distance>=min_distance)
                ns=accelerate;
            else
                ns=stop;
            accelerate:if( leading_distance<min_distance || car_speed > speed_limit)
                ns=decelerate;
            else
                ns=accelerate;
            decelerate:if(leading_distance>=min_distance && car_speed < speed_limit)
                ns=accelerate;
            else if(car_speed==0)
                ns=stop;
            else
                ns=decelerate;
            default:
            ns=stop;
        endcase
    end
    always @(cs)begin
        case(cs)
            stop:begin
                unlock_door=1;
                accelerate_car=0;
            end
            accelerate:begin
                unlock_door=0;
                accelerate_car=1;
            end
            decelerate:begin
                unlock_door=0;
                accelerate_car=0;
            end
            default:begin
                unlock_door=1;
                accelerate_car=0;
            end
        endcase
    end
endmodule

module Q2_FSM_tb();
    reg clk,rst;
    reg [7:0]speed_limit,car_speed;
    reg [6:0]leading_distance;
    wire unlock_door,accelerate_car;
    parameter min_distance=7'd40;

    Q2_FSM #(.min_distance(min_distance)) dut(speed_limit,car_speed,leading_distance,clk,rst,unlock_door,accelerate_car);
    initial begin
        clk=0;
        forever
            #2 clk=~clk;
    end

    initial begin
        rst=1;
        #10
        rst=0;
        //take a road of speed limit 120
        speed_limit=8'd120;
        leading_distance=7'd200;
        // start speed 0 
        car_speed=0;
        // then goto accelerate state
        #20 // after 20 time speed increase 
        car_speed=8'd50;
        leading_distance=7'd180;
        #20
        car_speed=8'd180;
        leading_distance=7'd70;
        //the speed cross the limit then we go decelerate 
        #10
        car_speed=8'd160;
        leading_distance=7'd95;
        #10
        car_speed=8'd100;
        leading_distance=7'd95;
        #10 // crouded place
        car_speed=8'd100;
        leading_distance=7'd30;
        #10 //slowing down 
        car_speed=8'd50;
        leading_distance=7'd20;
        #10 //still croude
        car_speed=8'd0;
        leading_distance=7'd5;
        #10 //  road starts to move again acc state 
        car_speed=8'd0;
        leading_distance=7'd45;
        #10
        car_speed=8'd100;
        leading_distance=7'd45;
        #10
        $stop;
    end
endmodule
