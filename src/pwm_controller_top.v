//pwm controller module

/*takes in clock, rstn, duty_cycle from 0 - 255 and outputs pwm_out with the corresponding duty_cycle
ie if duty_cycle = 255 output duty_cycle will be 100%
*/

module pwm_controller(
    //input
    input clk,
    input rstn,
//    input [7:0] duty_cycle,
    //outputs
    output reg pwm_out );

parameter TIME_PERIOD = 26'd269999;   //for 100Hz clock tick
reg [25:0] seconds_tick;        //counter for 1Hz clock source                                                                  //

reg [7:0] count;
reg [7:0] dc = 8'b1111_1110;

//always @(posedge clk or negedge rstn) begin                         //1Hz generator
//    if(!rstn) begin
//        dc <= 8'b0000_0000;
//        seconds_tick <= 26'd0;                                               //reset handling of 1Hz generator
//    end
//    else if(seconds_tick == TIME_PERIOD) begin
//        seconds_tick <= 26'd0;
//        if (count == dc) begin
//            dc <= dc + 1'b1;
//        end
//    end
//    else
//        seconds_tick <= seconds_tick + 1'd1;                                 //100Hz generate from 27MHz
//end

always @(posedge clk or negedge rstn) begin // pwm controller
    if(!rstn) begin
        count <= 8'b0000_0000;
        pwm_out <= 0;
    end
    else begin
        if(count == dc) begin
            count <= 8'b0000_0000;
            pwm_out <= 0;
        end
        else begin
            pwm_out = 1'b1;
            count <= count + 1'b1;
        end
    end
end

endmodule