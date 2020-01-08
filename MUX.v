`timescale 1ns / 1ps

module MUX #(parameter bits = 32)(
    input [bits-1:0] A, B,
    input sel,
    output [bits-1:0] out
);

assign out = sel ? A : B;

endmodule