module m_wave(
    input CLK_25K,
    output m_seq
);
reg [5:0] m_reg=6'b111111; // 6位移位寄存器

always @(posedge CLK_25K) begin
    m_reg <= {m_reg[4:0], m_reg[5] ^ m_reg[4]};
    // 反馈多项式 x^6 + x^5 + 1
    // 将第6位和第5位异或后输入到第1位
end

assign m_seq = m_reg[5]; // 取寄存器最高位作为调制信号
endmodule
