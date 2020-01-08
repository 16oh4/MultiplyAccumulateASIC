`timescale 1ns / 1ps
module CTRL_SIM();

reg clk;
always #5 clk = ~clk; //T = 1/10ns F = 10GHz
initial clk = 1'b0;

reg [1:0] func;

wire [1:0] ctrl, state_c;

reg [1:0] func_reg;

CTRL UUT(
.clk(clk),
.func(func),

.ctrl(ctrl),
.state_c(state_c)
);

always@(posedge clk) begin
    func_reg <= func;
end

initial begin
func = 2'b00;

end


endmodule