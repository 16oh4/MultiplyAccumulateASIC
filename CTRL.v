`timescale 1ns/1ps
module CTRL(
    input clk,
    input [1:0] func,
    
    output reg [1:0] ctrl,
    output [1:0] state_c
);

reg [1:0] state, n_state;

assign state_c = state;

initial state = 2'b00;

//If func changes, then go to state 1 to begin
always@(func) begin
    n_state = 2'b01;
end

//advance states at posedge
always@(posedge clk) begin
    state <= n_state;
end

//remove ctrl signals at negedge
always@(negedge clk) begin
    ctrl <= 2'bzz;
end

//assess change of state
always@(state) begin
    case(state)
        2'b00: begin //reset
            n_state = 2'b00; 
        end
        2'b01: begin  //pipeline stage 1
            n_state <= 2'b10;
            ctrl <= func; //send control signal to datapath
        end 
        2'b10: begin //pipeline stage 2
            n_state = 2'b00;
            ctrl <= func;            
        end
        2'b11: begin //idle
            n_state = n_state; 
        end 
        default: n_state = n_state;
    endcase
end

endmodule