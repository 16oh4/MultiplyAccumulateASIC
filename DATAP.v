`timescale 1ns/1ps
module DATAP #(parameter bits = 32)(
    input clk,
    input [1:0] func,
    input [bits-1:0] A,B,C,
    
    output [bits*2-1:0] result, //needs to be as big as mult result
    output reg [1:0] func_reg,
    output reg [bits*2-1:0] mult_out_reg,
    output reg [bits-1:0] c_reg
);

//Pipeline stage registers
/*
reg [1:0] func_reg;
reg [bits*2-1:0] mult_out_reg;
reg [bits-1:0] c_reg;
*/

//Internal wires
wire [bits-1:0] mux_ps1, mux_ps2;
wire [bits*2-1:0] mult_out;
//wire [bits*2-1:0] result_w;

always@(posedge clk) begin
    func_reg <= func;
    mult_out_reg <= mult_out;
    c_reg <= C;
    //result <= result_w;
end

//BEGIN pipeline stage 1
MUX #(bits) MUX_PS1(
.A(1'b1),
.B(B),
.sel(func[0]),

.out(mux_ps1)
);

ARRAY_MULTIPLIER #(bits) MULT(
.a(A),
.b(mux_ps1),

.p(mult_out)
);
//END pipeline stage 1


//BEGIN pipeline stage 2
wire mux_ps2_sel;
wire [bits*2-1:0] mux_ps2_ext;

//have to sign extend the output of mux for adder
//since result of multiplier is bits*2
assign mux_ps2_ext = { {bits{mux_ps2[bits-1]}}, mux_ps2 };

MUX #(bits) MUX_PS2(
.A(1'b0),
.B(c_reg),
.sel(mux_ps2_sel),

.out(mux_ps2)
);


CLA #(bits*2) ADDER(
.A(mult_out_reg),
.B(mux_ps2_ext),
.Cin(1'b0),

.Sum(result),
.Cout()
);

//Input to mux select to coincide with func
nor(mux_ps2_sel, func_reg[1], func_reg[0]);

//END pipeline stage 2

endmodule