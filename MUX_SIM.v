`timescale 1ns / 1ps
module MUX_SIM();

parameter bits = 32;

reg [bits-1:0] A,B;
reg sel;

wire [bits-1:0] out;

MUX #(bits) UUT(
.A(A),
.B(B),
.sel(sel),

.out(out)
);

initial begin
A = 32'h2ABC_D3F7;
B = 32'h0732_B43D;

sel = 0;

#10 sel = 1;


end

endmodule