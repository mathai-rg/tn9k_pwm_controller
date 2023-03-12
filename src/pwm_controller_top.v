//pwm controller module

/*takes in clock, rstn, duty_cycle from 0 - 255 and outputs pwm_out with the corresponding duty_cycle
ie if duty_cycle = 255 output duty_cycle will be 100%
*/

module pwm_controller(
    //input
    input clk,
    input rstn,
    input [7:0] duty_cycle,
    //outputs
    output reg pwm_out );

reg [7:0] dc_count;
reg [17:0] tick;

always @(posedge clk or negedge rstn) begin // pwm output controller
    if(!rstn) begin
        pwm_out <= 1'b0;
    end
    else begin
        if(dc_count <= duty_cycle) begin
            pwm_out <= 1'b1;
        end
        else begin
            pwm_out <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rstn) begin //counter
    if(!rstn) begin
        dc_count <= 8'b0000_0000;
    end
    else begin
        dc_count <= dc_count + 1'b1;
    end
end

endmodule