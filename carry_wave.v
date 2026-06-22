module carry_wave(
    input CLK_26M,
    output signed [7:0] carry_cos
);
reg [8:0] rom_addr=9'd65; 
wire [7:0]douta;
assign carry_cos=douta-'d127;
rom_carry inst_rom_carry(
    .clka(CLK_26M),
    .addra(rom_addr),  
    .douta(douta) 
);
always @(posedge CLK_26M) begin
    if (rom_addr == 9'd259) begin
        rom_addr <= 9'd0; 
    end 
    else begin
        rom_addr <= rom_addr + 1'b1;
    end
end


endmodule
