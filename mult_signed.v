module mult_signed #(
    parameter A_WIDTH = 8,
    parameter B_WIDTH = 8
)(
    input                        CLK,
    input  signed [A_WIDTH-1:0]  A,
    input  signed [B_WIDTH-1:0]  B,
    output reg signed [A_WIDTH+B_WIDTH-1:0] P=0
);
always @(posedge CLK) begin
    P <= A * B;
end
endmodule
