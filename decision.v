module decision (
    input wire        clk,
    input wire [7:0]  data_in,
    output            data_out
);
reg decision_out_reg = 1'b0;

always @(posedge clk) begin
    // 门限设为包络峰值（80）的2/pi
    decision_out_reg <= (data_in > 8'd40) ? 1'b1 : 1'b0; 
end
assign data_out = decision_out_reg;
endmodule
