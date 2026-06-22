module coherent_dem(
    input CLK_26M,
    input CLK_25K,
    input sample_clk,       
    input signed [7:0]ask_out,
    output coherent_out
);
wire signed [15:0] mult_I_out;
wire signed [15:0] mult_Q_out;
wire signed [7:0] Data_cos;
wire signed [7:0] Data_sin;
wire signed [31:0] freq_adj;

// DDS 与乘法器 
DDS_AD9767 inst_dds(
    .Clk(CLK_26M),
    .Data_sin(Data_sin),
    .Data_cos(Data_cos),
    .freq_adj(freq_adj)
);

mult_signed #(
    .A_WIDTH(8),
    .B_WIDTH(8)
) inst_mul_I (
    .CLK(CLK_26M), 
    .A(Data_cos),      
    .B(ask_out),      
    .P(mult_I_out)
);

mult_signed #(
    .A_WIDTH(8),
    .B_WIDTH(8)
) inst_mul_Q (
    .CLK(CLK_26M),  
    .A(Data_sin),      
    .B(ask_out),      
    .P(mult_Q_out)    
);

// 128点滑动平均低通滤波
reg [128*16-1 : 0] shift_reg_I_bus= {(128*16){1'b0}};
reg [128*16-1 : 0] shift_reg_Q_bus= {(128*16){1'b0}};
reg signed [22:0] sum_I= 23'sd0;
reg signed [22:0] sum_Q= 23'sd0;

// 提取最老的一个点 (第128个点)
wire signed [15:0] I_oldest = shift_reg_I_bus[128*16-1 : 127*16];
wire signed [15:0] Q_oldest = shift_reg_Q_bus[128*16-1 : 127*16];

always @(posedge CLK_26M) begin
    // 移位操作：左移16位，把新数据拼在最低端
    shift_reg_I_bus <= {shift_reg_I_bus[127*16-1 : 0], mult_I_out};
    shift_reg_Q_bus <= {shift_reg_Q_bus[127*16-1 : 0], mult_Q_out};
    // 累加器更新：加上最新值，减去最老值
    sum_I <= sum_I + mult_I_out - I_oldest;
    sum_Q <= sum_Q + mult_Q_out - Q_oldest;
end

wire signed [15:0] I_LPF = sum_I[22:7];  
wire signed [15:0] Q_LPF = sum_Q[22:7];  

// 极性 Costas 环鉴相器
wire signed [15:0] phase_error_raw;
// 建立正确的负反馈闭环
assign phase_error_raw = (I_LPF[15] == 1'b0) ? (~Q_LPF + 1'b1) : Q_LPF;

wire signed [31:0] phase_error_ext = phase_error_raw; 
wire signed [31:0] phase_error;
assign phase_error = phase_error_ext >>> 4;          
// 环路滤波器
wire rx_flywheel_en = (I_LPF > 16'sd500); // 当解调幅度足够大时，认为收到了 '1
loop_filter inst_loop_filter (
    .Clk(sample_clk),
    .code_en(rx_flywheel_en),
    .error_in(phase_error),
    .freq_adj(freq_adj)
);
// 码元判决与coherent_out 输出
reg coherent_out_reg= 1'b0;

always @(posedge CLK_26M) begin
    // 门限设为峰值的二分之一
    coherent_out_reg <= (I_LPF > 16'sd3100) ? 1'b1 : 1'b0; 
end
assign coherent_out = coherent_out_reg;
endmodule