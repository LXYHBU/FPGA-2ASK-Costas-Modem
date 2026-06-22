module fir (
    input         clk_in,        
    input  [7:0]  filterDataIn,  // 整流后数据输入
    output [7:0]  filterDataOut  // 滤波后平滑输出
);
reg  [128*8-1 : 0] shift_reg_bus = {(128*8){1'b0}};
reg  [15:0] sum = 16'd0;
wire [7:0] oldest_data = shift_reg_bus[128*8-1 : 127*8];
wire [7:0] clean_in;
assign clean_in = (^filterDataIn === 1'bx) ? 8'd0 : filterDataIn;

always @(posedge clk_in) begin
//移位更新
//将新来的数据拼在最低位，其他数据整体向高位移动 8 位
    shift_reg_bus <= {shift_reg_bus[127*8-1 : 0], clean_in};
//累加器更新
//当前总和 = 上一次的总和 + 新进入窗口的数据 - 被挤出窗口的最老数据
    sum <= sum + clean_in - oldest_data; 
end
//将 128 点的总和除以 128 以求得平均值。
//除以 128 等同于将二进制数向右移 7 位 (2^7 = 128)。
//取 sum 的 [14:7] 位作为最终输出。
assign filterDataOut = sum[14:7];

endmodule