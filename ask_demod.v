/************************************************************
 * 模块名 : ask_demod
 * 功能   : 对输入的ASK调制信号进行全波整流（取绝对值）
 * 输入   : clk_in          - 时钟
 *         ask_signal_in    - 待整流的信号（有符号补码）
 * 输出   : ask_demod_signal- 整流后的信号（无符号绝对值）
 * 参数   : WIDTH           - 数据位宽，默认8位
 ************************************************************/
module ask_demod (
    input  wire        clk_in,          // 时钟
    input  wire [7:0]  ask_signal_in,   // 输入已调信号（有符号）
    output reg  [7:0]  ask_demod_signal // 整流后输出
);

    // 组合逻辑计算绝对值
    wire [7:0] abs_value;

    assign abs_value = (ask_signal_in[7] == 1'b1) ? 
                       (~ask_signal_in + 8'd1) :   // 负数取补码绝对值
                       ask_signal_in;               // 非负数直接输出

    // 时钟同步输出，避免毛刺
    always @(posedge clk_in) begin
        ask_demod_signal <= abs_value;
    end

endmodule