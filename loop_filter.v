module loop_filter #(
    parameter ERROR_WIDTH = 32,   
    parameter ADJ_WIDTH   = 32,   
    parameter Kp          = 32, // 大幅调低比例系数，防止对毛刺过度反应
    parameter Ki          = 1   // 调低积分系数，防止积分器爆炸
)(
    input               Clk,
    input               code_en,        
    input  signed [ERROR_WIDTH-1:0]  error_in,
    output reg signed [ADJ_WIDTH-1:0] freq_adj= 'sd0
);
// 积分累加器
reg signed [ERROR_WIDTH+16:0] integral= 'sd0;
// 完整的PI运算结果
wire signed [ERROR_WIDTH+16:0] pi_out_full;

assign pi_out_full = (error_in * Kp) + (integral * Ki);
always @(posedge Clk) begin
    if(code_en) begin 
        integral <= integral + error_in;
        // 算术右移能完美保留负数的符号位，彻底防止高频跑飞！
        freq_adj <= pi_out_full >>> 4; 
    end
end
endmodule
