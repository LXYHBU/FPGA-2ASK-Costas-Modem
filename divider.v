module divider (
    input  wire        clk_in,          
    input  wire [15:0] div_ratio,   //分频系数   
    input  wire [15:0] duty_cycle,  //占空比系数 
    output reg         clk_out=1'b0     
);
reg [15:0] cnt= 16'd0;

always @(posedge clk_in ) begin
    if (div_ratio == 16'd0) begin
        cnt <= 16'd0;
        clk_out <= ~clk_out;  
    end else begin
        if (cnt >= div_ratio - 16'd1) begin
            cnt <= 16'd0;
        end else begin
            cnt <= cnt + 16'd1;
        end
            clk_out <= (cnt < duty_cycle) ? 1'b1 : 1'b0;
        end
    end

endmodule