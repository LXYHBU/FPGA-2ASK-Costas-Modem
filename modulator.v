module modulator(
    input m_seq,
    input [7:0] carry_in,
    output  signed [7:0] ask_out
);
assign ask_out = carry_in*m_seq;
endmodule
