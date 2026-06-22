`timescale 1ns / 1ps
module top_tb();
reg Clk;
reg Rst_n;
top inst_top(
    .Clk(Clk),
    .Rst_n(Rst_n)
);
initial begin
    Clk=0;
    Rst_n=1;
    #20
    Rst_n=0;
    #20
    Rst_n=1;
end
always #10 Clk=~Clk;
endmodule
