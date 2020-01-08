`timescale 1ns / 1ps
module DATAP_SIM();

parameter bits = 32;

//inputs to datapath
reg [bits-1:0] A,B,C;
reg [1:0] func;
reg clk;

always #5 clk = ~clk;
initial clk = 1'b0;

//outputs from datapath
wire [bits*2-1:0] mult_out_reg, result;
wire [1:0] func_reg;
wire [bits-1:0] c_reg;

DATAP #(bits) UUT(
.clk(clk),
.func(func),
.A(A),
.B(B),
.C(C),

.result(result),
.func_reg(func_reg),
.mult_out_reg(mult_out_reg),
.c_reg(c_reg)
);

initial begin

    //test 1
    A = 32'h0000_0002;
    B = 32'h0000_0007;
    C = 32'h0000_0001;
    
    func = 2'b00; // A * B    
    #10;    
    func = 2'b01; // A + C    
    #10;    
    func = 2'b10; // A*B+
    
    #10;
    
    //test2
    A = 32'h0000_0003;
    B = 32'h0000_0004;
    C = 32'h0000_0002;
    
    func = 2'b00; // A * B    
    #10;    
    func = 2'b01; // A + C    
    #10;    
    func = 2'b10; // A*B+   
    

end


endmodule