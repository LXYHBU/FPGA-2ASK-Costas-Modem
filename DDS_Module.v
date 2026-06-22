module DDS_Module(
    input Clk,
    input [31:0] Fword,//频率控制字
    input [7:0]  Pword,//相位控制字          
    output wire signed [7:0] Data_sin,
    output wire signed [7:0] Data_cos
);
wire [7:0] Data_sinr;
wire [7:0] Data_cosr;
// 无符号到有符号的转换
assign Data_sin =Data_sinr - 8'd127;
assign Data_cos =Data_cosr - 8'd127;
// 频率控制字同步寄存器
reg [31:0] Fword_r=32'd0;
always@(posedge Clk)begin
    Fword_r <= Fword;
end
// 相位控制字同步寄存器
reg [7:0] Pword_r= 8'd0;            
always@(posedge Clk)begin
    Pword_r <= Pword; 
end
// 相位累加器    
reg [31:0] Freq_ACC=32'd0;
always@(posedge Clk)begin
    Freq_ACC <= Fword_r + Freq_ACC;
end
// 波形数据表地址
wire [7:0] Rom_Addr_sin;      
wire [7:0] Rom_Addr_cos;      
// 相位截断：取 32 位累加器的高 8 位
assign Rom_Addr_sin = Freq_ACC[31:24] + Pword_r;
// cos与sin的 90 度偏移
assign Rom_Addr_cos = Rom_Addr_sin + 8'd64; 
// ROM例化
my_rom rom_sine(
    .clka(Clk),
    .addra(Rom_Addr_sin),
    .douta(Data_sinr)
);
my_rom rom_cos(
    .clka(Clk),
    .addra(Rom_Addr_cos),
    .douta(Data_cosr)
);
endmodule