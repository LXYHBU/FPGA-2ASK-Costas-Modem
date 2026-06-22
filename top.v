module top(
    input Clk,
    input Rst_n
);
//PLL
wire CLK_26M;               //XSRP主时钟
wire locked;                //锁定标志
//inst_divider
wire CLK_25K;               //调制信号频率
wire CLK_100K;              //载波频率
wire sample_clk;            //500K 滤波器采样频率
//inst_carry
wire signed [7:0]carry_cos; //原始载波
//inst_modu
wire signed [7:0]ask_out;   //调制后信号
//inst_ask_demod
wire [7:0]demod_out;        //整流输出
//inst_fir
wire [7:0]fir_out;          //整流后滤波输出
//inst_m_wave
wire m_seq;                 //m序列
//inst_decison                
wire deci_out;              //非相干解调输出
//inst_coherent
wire coherent_out;          //相干解调输出
///////////////////////////PLL////////////////////////
PLL inst_PLL
(
    .clk_out1(CLK_26M),
    .resetn(Rst_n), 
    .locked(locked),       
    .clk_in1(Clk)
);      
///////////////////////////分频////////////////////////
divider inst_divider_0(//输入26M，输出100K 50%
    .clk_in(CLK_26M),           
    .div_ratio(16'd260),  
    .duty_cycle(16'd130),  
    .clk_out(CLK_100K)      
);
divider inst_divider_1(//输入100K，输出25K 50%
    .clk_in(CLK_100K),        
    .div_ratio(16'd4),  
    .duty_cycle(16'd2),  
    .clk_out(CLK_25K)      
);
divider inst_divider_2(//输入26K，输出500K 50%
    .clk_in(CLK_26M),        
    .div_ratio(16'd52),  
    .duty_cycle(16'd26),  
    .clk_out(sample_clk)      
);
///////////////////////////载波生成////////////////////////
carry_wave inst_carry_wave(
    .CLK_26M(CLK_26M),
    .carry_cos(carry_cos)
);
///////////////////////////调制波生成////////////////////////
m_wave inst_m_wave(
    .CLK_25K(CLK_25K),
    .m_seq(m_seq)
);
///////////////////////////乘法调制////////////////////////
modulator inst_modu(
    .m_seq(m_seq),
    .carry_in(carry_cos),
    .ask_out(ask_out)
);
//非相干解调
ask_demod  inst_ask_demod (
    .clk_in(CLK_26M),
    .ask_signal_in(ask_out),
    .ask_demod_signal(demod_out)
);
///////////////////////////整流后滤波(非相干)////////////////////////
fir inst_fir(
    .clk_in(CLK_26M),          // 26MHz 主时钟
    .filterDataIn(demod_out),   // 来自整流模块的信号
    .filterDataOut(fir_out)     // 提取出的包络信号
);
///////////////////////////抽样判决(非相干)////////////////////////
decision inst_decison(
    .clk(CLK_26M),
    .data_in(fir_out),
    .data_out(deci_out)
);
///////////////////////////相干解调提取载波////////////////////////
coherent_dem inst_coherent(
    .CLK_26M(CLK_26M),
    .CLK_25K(CLK_25K),
    .ask_out(ask_out),
    .sample_clk(sample_clk),//环路滤波器采样率（500K）： 码元速率的20倍
    .coherent_out(coherent_out)
);
endmodule
