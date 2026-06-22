module rom_carry(
    input clka,
    input [8:0] addra,  
    output reg [7:0] douta = 8'h7F 
);
// 强制综合器使用 Block RAM 资源
(* rom_style="block" *) reg [7:0] rom_mem [0:259];
initial begin
    rom_mem[9'd0] = 8'h7F; rom_mem[9'd1] = 8'h82; rom_mem[9'd2] = 8'h85; rom_mem[9'd3] = 8'h88; rom_mem[9'd4] = 8'h8B; rom_mem[9'd5] = 8'h8E; rom_mem[9'd6] = 8'h91; rom_mem[9'd7] = 8'h94; 
    rom_mem[9'd8] = 8'h97; rom_mem[9'd9] = 8'h9A; rom_mem[9'd10] = 8'h9D; rom_mem[9'd11] = 8'hA0; rom_mem[9'd12] = 8'hA3; rom_mem[9'd13] = 8'hA6; rom_mem[9'd14] = 8'hA9; rom_mem[9'd15] = 8'hAC; 
    rom_mem[9'd16] = 8'hAF; rom_mem[9'd17] = 8'hB2; rom_mem[9'd18] = 8'hB5; rom_mem[9'd19] = 8'hB7; rom_mem[9'd20] = 8'hBA; rom_mem[9'd21] = 8'hBD; rom_mem[9'd22] = 8'hBF; rom_mem[9'd23] = 8'hC2; 
    rom_mem[9'd24] = 8'hC5; rom_mem[9'd25] = 8'hC7; rom_mem[9'd26] = 8'hCA; rom_mem[9'd27] = 8'hCC; rom_mem[9'd28] = 8'hCF; rom_mem[9'd29] = 8'hD1; rom_mem[9'd30] = 8'hD3; rom_mem[9'd31] = 8'hD5; 
    rom_mem[9'd32] = 8'hD8; rom_mem[9'd33] = 8'hDA; rom_mem[9'd34] = 8'hDC; rom_mem[9'd35] = 8'hDE; rom_mem[9'd36] = 8'hE0; rom_mem[9'd37] = 8'hE2; rom_mem[9'd38] = 8'hE4; rom_mem[9'd39] = 8'hE6; 
    rom_mem[9'd40] = 8'hE8; rom_mem[9'd41] = 8'hE9; rom_mem[9'd42] = 8'hEB; rom_mem[9'd43] = 8'hEC; rom_mem[9'd44] = 8'hEE; rom_mem[9'd45] = 8'hEF; rom_mem[9'd46] = 8'hF1; rom_mem[9'd47] = 8'hF2; 
    rom_mem[9'd48] = 8'hF3; rom_mem[9'd49] = 8'hF5; rom_mem[9'd50] = 8'hF6; rom_mem[9'd51] = 8'hF7; rom_mem[9'd52] = 8'hF8; rom_mem[9'd53] = 8'hF9; rom_mem[9'd54] = 8'hFA; rom_mem[9'd55] = 8'hFA; 
    rom_mem[9'd56] = 8'hFB; rom_mem[9'd57] = 8'hFC; rom_mem[9'd58] = 8'hFC; rom_mem[9'd59] = 8'hFD; rom_mem[9'd60] = 8'hFD; rom_mem[9'd61] = 8'hFD; rom_mem[9'd62] = 8'hFE; rom_mem[9'd63] = 8'hFE; 
    rom_mem[9'd64] = 8'hFE; rom_mem[9'd65] = 8'hFE; rom_mem[9'd66] = 8'hFE; rom_mem[9'd67] = 8'hFE; rom_mem[9'd68] = 8'hFE; rom_mem[9'd69] = 8'hFD; rom_mem[9'd70] = 8'hFD; rom_mem[9'd71] = 8'hFD; 
    rom_mem[9'd72] = 8'hFC; rom_mem[9'd73] = 8'hFC; rom_mem[9'd74] = 8'hFB; rom_mem[9'd75] = 8'hFA; rom_mem[9'd76] = 8'hFA; rom_mem[9'd77] = 8'hF9; rom_mem[9'd78] = 8'hF8; rom_mem[9'd79] = 8'hF7; 
    rom_mem[9'd80] = 8'hF6; rom_mem[9'd81] = 8'hF5; rom_mem[9'd82] = 8'hF3; rom_mem[9'd83] = 8'hF2; rom_mem[9'd84] = 8'hF1; rom_mem[9'd85] = 8'hEF; rom_mem[9'd86] = 8'hEE; rom_mem[9'd87] = 8'hEC; 
    rom_mem[9'd88] = 8'hEB; rom_mem[9'd89] = 8'hE9; rom_mem[9'd90] = 8'hE8; rom_mem[9'd91] = 8'hE6; rom_mem[9'd92] = 8'hE4; rom_mem[9'd93] = 8'hE2; rom_mem[9'd94] = 8'hE0; rom_mem[9'd95] = 8'hDE; 
    rom_mem[9'd96] = 8'hDC; rom_mem[9'd97] = 8'hDA; rom_mem[9'd98] = 8'hD8; rom_mem[9'd99] = 8'hD5; rom_mem[9'd100] = 8'hD3; rom_mem[9'd101] = 8'hD1; rom_mem[9'd102] = 8'hCF; rom_mem[9'd103] = 8'hCC; 
    rom_mem[9'd104] = 8'hCA; rom_mem[9'd105] = 8'hC7; rom_mem[9'd106] = 8'hC5; rom_mem[9'd107] = 8'hC2; rom_mem[9'd108] = 8'hBF; rom_mem[9'd109] = 8'hBD; rom_mem[9'd110] = 8'hBA; rom_mem[9'd111] = 8'hB7; 
    rom_mem[9'd112] = 8'hB5; rom_mem[9'd113] = 8'hB2; rom_mem[9'd114] = 8'hAF; rom_mem[9'd115] = 8'hAC; rom_mem[9'd116] = 8'hA9; rom_mem[9'd117] = 8'hA6; rom_mem[9'd118] = 8'hA3; rom_mem[9'd119] = 8'hA0; 
    rom_mem[9'd120] = 8'h9D; rom_mem[9'd121] = 8'h9A; rom_mem[9'd122] = 8'h97; rom_mem[9'd123] = 8'h94; rom_mem[9'd124] = 8'h91; rom_mem[9'd125] = 8'h8E; rom_mem[9'd126] = 8'h8B; rom_mem[9'd127] = 8'h88; 
    rom_mem[9'd128] = 8'h85; rom_mem[9'd129] = 8'h82; rom_mem[9'd130] = 8'h7F; rom_mem[9'd131] = 8'h7C; rom_mem[9'd132] = 8'h79; rom_mem[9'd133] = 8'h76; rom_mem[9'd134] = 8'h73; rom_mem[9'd135] = 8'h70; 
    rom_mem[9'd136] = 8'h6D; rom_mem[9'd137] = 8'h6A; rom_mem[9'd138] = 8'h67; rom_mem[9'd139] = 8'h64; rom_mem[9'd140] = 8'h61; rom_mem[9'd141] = 8'h5E; rom_mem[9'd142] = 8'h5B; rom_mem[9'd143] = 8'h58; 
    rom_mem[9'd144] = 8'h55; rom_mem[9'd145] = 8'h52; rom_mem[9'd146] = 8'h4F; rom_mem[9'd147] = 8'h4C; rom_mem[9'd148] = 8'h49; rom_mem[9'd149] = 8'h47; rom_mem[9'd150] = 8'h44; rom_mem[9'd151] = 8'h41; 
    rom_mem[9'd152] = 8'h3F; rom_mem[9'd153] = 8'h3C; rom_mem[9'd154] = 8'h39; rom_mem[9'd155] = 8'h37; rom_mem[9'd156] = 8'h34; rom_mem[9'd157] = 8'h32; rom_mem[9'd158] = 8'h2F; rom_mem[9'd159] = 8'h2D; 
    rom_mem[9'd160] = 8'h2B; rom_mem[9'd161] = 8'h29; rom_mem[9'd162] = 8'h26; rom_mem[9'd163] = 8'h24; rom_mem[9'd164] = 8'h22; rom_mem[9'd165] = 8'h20; rom_mem[9'd166] = 8'h1E; rom_mem[9'd167] = 8'h1C; 
    rom_mem[9'd168] = 8'h1A; rom_mem[9'd169] = 8'h18; rom_mem[9'd170] = 8'h16; rom_mem[9'd171] = 8'h15; rom_mem[9'd172] = 8'h13; rom_mem[9'd173] = 8'h12; rom_mem[9'd174] = 8'h10; rom_mem[9'd175] = 8'h0F; 
    rom_mem[9'd176] = 8'h0D; rom_mem[9'd177] = 8'h0C; rom_mem[9'd178] = 8'h0B; rom_mem[9'd179] = 8'h09; rom_mem[9'd180] = 8'h08; rom_mem[9'd181] = 8'h07; rom_mem[9'd182] = 8'h06; rom_mem[9'd183] = 8'h05; 
    rom_mem[9'd184] = 8'h04; rom_mem[9'd185] = 8'h04; rom_mem[9'd186] = 8'h03; rom_mem[9'd187] = 8'h02; rom_mem[9'd188] = 8'h02; rom_mem[9'd189] = 8'h01; rom_mem[9'd190] = 8'h01; rom_mem[9'd191] = 8'h01; 
    rom_mem[9'd192] = 8'h00; rom_mem[9'd193] = 8'h00; rom_mem[9'd194] = 8'h00; rom_mem[9'd195] = 8'h00; rom_mem[9'd196] = 8'h00; rom_mem[9'd197] = 8'h00; rom_mem[9'd198] = 8'h00; rom_mem[9'd199] = 8'h01; 
    rom_mem[9'd200] = 8'h01; rom_mem[9'd201] = 8'h01; rom_mem[9'd202] = 8'h02; rom_mem[9'd203] = 8'h02; rom_mem[9'd204] = 8'h03; rom_mem[9'd205] = 8'h04; rom_mem[9'd206] = 8'h04; rom_mem[9'd207] = 8'h05; 
    rom_mem[9'd208] = 8'h06; rom_mem[9'd209] = 8'h07; rom_mem[9'd210] = 8'h08; rom_mem[9'd211] = 8'h09; rom_mem[9'd212] = 8'h0B; rom_mem[9'd213] = 8'h0C; rom_mem[9'd214] = 8'h0D; rom_mem[9'd215] = 8'h0F; 
    rom_mem[9'd216] = 8'h10; rom_mem[9'd217] = 8'h12; rom_mem[9'd218] = 8'h13; rom_mem[9'd219] = 8'h15; rom_mem[9'd220] = 8'h16; rom_mem[9'd221] = 8'h18; rom_mem[9'd222] = 8'h1A; rom_mem[9'd223] = 8'h1C; 
    rom_mem[9'd224] = 8'h1E; rom_mem[9'd225] = 8'h20; rom_mem[9'd226] = 8'h22; rom_mem[9'd227] = 8'h24; rom_mem[9'd228] = 8'h26; rom_mem[9'd229] = 8'h29; rom_mem[9'd230] = 8'h2B; rom_mem[9'd231] = 8'h2D; 
    rom_mem[9'd232] = 8'h2F; rom_mem[9'd233] = 8'h32; rom_mem[9'd234] = 8'h34; rom_mem[9'd235] = 8'h37; rom_mem[9'd236] = 8'h39; rom_mem[9'd237] = 8'h3C; rom_mem[9'd238] = 8'h3F; rom_mem[9'd239] = 8'h41; 
    rom_mem[9'd240] = 8'h44; rom_mem[9'd241] = 8'h47; rom_mem[9'd242] = 8'h49; rom_mem[9'd243] = 8'h4C; rom_mem[9'd244] = 8'h4F; rom_mem[9'd245] = 8'h52; rom_mem[9'd246] = 8'h55; rom_mem[9'd247] = 8'h58; 
    rom_mem[9'd248] = 8'h5B; rom_mem[9'd249] = 8'h5E; rom_mem[9'd250] = 8'h61; rom_mem[9'd251] = 8'h64; rom_mem[9'd252] = 8'h67; rom_mem[9'd253] = 8'h6A; rom_mem[9'd254] = 8'h6D; rom_mem[9'd255] = 8'h70; 
    rom_mem[9'd256] = 8'h73; rom_mem[9'd257] = 8'h76; rom_mem[9'd258] = 8'h79; rom_mem[9'd259] = 8'h7C; 
end

// 时钟同步读逻辑
always @(posedge clka) begin
    douta <= rom_mem[addra];
end
endmodule