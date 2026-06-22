module DDS_AD9767(
    input Clk,
    output signed [7:0] Data_sin,
    output signed [7:0] Data_cos,
    input signed [31:0] freq_adj
);
reg [31:0] FwordA= 32'd0;
reg [7:0]  PwordA= 8'd0; 
    
DDS_Module DDS_ModuleA(
    .Clk(Clk),
    .Fword(FwordA),
    .Pword(PwordA),
    .Data_sin(Data_sin),
    .Data_cos(Data_cos)
);
always @(posedge Clk) begin
    FwordA <= $unsigned($signed({1'b0, 32'd16519105}) + freq_adj); //将常数变为有符号数参与运算，再变为无符号数
    PwordA <= 8'd32;//初始相位偏移45度，用于验证Costas环的有效性
end
//频率控制字计算公式:Fword=(目标输出频率*2^N)/工作时钟
endmodule