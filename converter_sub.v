`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Compa_to_gy: Sha_to_gghai Jiao Tong University
// Engineer: Venci Freeman
//
// Create Date: 04/27/2018
// Design Name: switch Code-number Converter
// Module Name: sub
// Project Name: converter
// Target Devices: BASYS 2 FPGA
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module converter_sub(freq, enable, clk, beep, clk_cnt, button0, switch, a_to_g);

    input [31:0] freq; // Frequency
    input enable; // Control buzzer
    input clk; // 50MHz clock
    input button0; // Control mode conversion
    input [7:0]switch;
    input [15:0]clk_cnt; // Clock division
    output beep; // Output to buzzer
    output [39:0]a_to_g; // Output storage

    reg [31:0] count; // Frequency division
    reg Beep; // Connect to beep
    reg [39:0] a_to_g;

    assign beep = Beep;

    parameter dit = 8'b01111111; // Constant definition: Morse code " . "
    parameter dah = 8'b11110111; // Constant definition: Morse code " _ "
    parameter null = 8'b11111111; // Constant definition: No input

always @ (posedge clk) begin // Generate signal count
    if(count >= freq) begin
        count <= 0;
        if(enable) Beep <= ~Beep;
    end
        else count <= count + 1;
end

always @ (switch or button0 or clk_cnt[15:14]) begin // Number to Morse code
    case({switch,button0})
        9'b011100000: a_to_g[39:32] <= 8'b10001000; // A: . _
        9'b110101010: a_to_g[39:32] <= 8'b11100000; // B: _ . . .
        9'b110111010: a_to_g[39:32] <= 8'b10110001; // C: _ . _ .
        9'b110101000: a_to_g[39:32] <= 8'b11000010; // D: _ . .
        9'b010000000: a_to_g[39:32] <= 8'b10110000; // E: .
        9'b010111010: a_to_g[39:32] <= 8'b10111000; // F: . . _ .
        9'b111101000: a_to_g[39:32] <= 8'b10100001; // G: _ _ .

        9'b010101010: a_to_g[39:32] <= 8'b11001000; // H: . . . .
        9'b010100000: a_to_g[39:32] <= 8'b10110011; // I: . .
        9'b011111110: a_to_g[39:32] <= 8'b10100111; // J: . _ _ _
        9'b110111000: a_to_g[39:32] <= 8'b11011000; // K: _ . _
        9'b011101010: a_to_g[39:32] <= 8'b11110001; // L: . _ . .
        9'b111100000: a_to_g[39:32] <= 8'b10101010; // M: _ _
        9'b110100000: a_to_g[39:32] <= 8'b11101010; // N: _ .

        9'b111111000: a_to_g[39:32] <= 8'b10100010; // O: _ _ _
        9'b011111010: a_to_g[39:32] <= 8'b10011000; // P: . _ _ .
        9'b111101110: a_to_g[39:32] <= 8'b10001100; // Q: _ _ . _
        9'b011101000: a_to_g[39:32] <= 8'b11111010; // R: . _ .
        9'b010101000: a_to_g[39:32] <= 8'b10100100; // S: . . .
        9'b110000000: a_to_g[39:32] <= 8'b11110000; // T: _

        9'b010111000: a_to_g[39:32] <= 8'b11000001; // U: . . _
        9'b010101110: a_to_g[39:32] <= 8'b11000011; // V: . . . _
        9'b011111000: a_to_g[39:32] <= 8'b11010100; // W: . _ _
        9'b110101110: a_to_g[39:32] <= 8'b10100011; // X: _ . . _
        9'b110111110: a_to_g[39:32] <= 8'b11000100; // Y: _ . _ _
        9'b111101010: a_to_g[39:32] <= 8'b10110110; // Z: _ _ . .
        default a_to_g[39:32] <= 8'b11111111; // null
    endcase

    case({switch,button0,clk_cnt[15:14]}) // Morse code to number
        11'b01000000100: a_to_g[31:24] <= dit; // A: . _
        11'b00100000100: a_to_g[31:24] <= dah; // B: _ . . .
        11'b00010000100: a_to_g[31:24] <= dah; // C: _ . _ .
        11'b00001000100: a_to_g[31:24] <= dah; // D: _ . .
        11'b00000100100: a_to_g[31:24] <= dit; // E: .
        11'b00000010100: a_to_g[31:24] <= dit; // F: . . _ .
        11'b00000001100: a_to_g[31:24] <= dah; // G: _ _ .

        11'b00111111100: a_to_g[31:24] <= dit; // H: . . . .
        11'b01011111100: a_to_g[31:24] <= dit; // I: . .
        11'b01101111100: a_to_g[31:24] <= dit; // J: . _ _ _
        11'b01110111100: a_to_g[31:24] <= dah; // K: _ . _
        11'b01111011100: a_to_g[31:24] <= dit; // L: . _ . .
        11'b01111101100: a_to_g[31:24] <= dah; // M: _ _
        11'b01111110100: a_to_g[31:24] <= dah; // N: _ .

        11'b11000000100: a_to_g[31:24] <= dah; // O: _ _ _
        11'b10100000100: a_to_g[31:24] <= dit; // P: . _ _ .
        11'b10010000100: a_to_g[31:24] <= dah; // Q: _ _ . _
        11'b10000100100: a_to_g[31:24] <= dit; // R: . _ .
        11'b10000010100: a_to_g[31:24] <= dit; // S: . . .
        11'b10000001100: a_to_g[31:24] <= dah; // T: _

        11'b10111111100: a_to_g[31:24] <= dit; // U: . . _
        11'b11011111100: a_to_g[31:24] <= dit; // V: . . . _
        11'b11101111100: a_to_g[31:24] <= dit; // W: . _ _
        11'b11111011100: a_to_g[31:24] <= dah; // X: _ . . _
        11'b11111101100: a_to_g[31:24] <= dah; // Y: _ . _ _
        11'b11111110100: a_to_g[31:24] <= dah; // Z: _ _ . .

        11'b01000000101: a_to_g[23:16] <= dah; // A: . _
        11'b00100000101: a_to_g[23:16] <= dit; // B: _ . . .
        11'b00010000101: a_to_g[23:16] <= dit; // C: _ . _ .
        11'b00001000101: a_to_g[23:16] <= dit; // D: _ . .
        11'b00000010101: a_to_g[23:16] <= dit; // F: . . _ .
        11'b00000001101: a_to_g[23:16] <= dah; // G: _ _ .

        11'b00111111101: a_to_g[23:16] <= dit; // H: . . . .
        11'b01011111101: a_to_g[23:16] <= dit; // I: . .
        11'b01101111101: a_to_g[23:16] <= dah; // J: . _ _ _
        11'b01110111101: a_to_g[23:16] <= dit; // K: _ . _
        11'b01111011101: a_to_g[23:16] <= dah; // L: . _ . .
        11'b01111101101: a_to_g[23:16] <= dah; // M: _ _
        11'b01111110101: a_to_g[23:16] <= dit; // N: _ .

        11'b11000000101: a_to_g[23:16] <= dah; // O: _ _ _
        11'b10100000101: a_to_g[23:16] <= dah; // P: . _ _ .
        11'b10010000101: a_to_g[23:16] <= dah; // Q: _ _ . _
        11'b10000100101: a_to_g[23:16] <= dah; // R: . _ .
        11'b10000010101: a_to_g[23:16] <= dit; // S: . . .

        11'b10111111101: a_to_g[23:16] <= dit; // U: . . _
        11'b11011111101: a_to_g[23:16] <= dit; // V: . . . _
        11'b11101111101: a_to_g[23:16] <= dah; // W: . _ _
        11'b11111011101: a_to_g[23:16] <= dit; // X: _ . . _
        11'b11111101101: a_to_g[23:16] <= dit; // Y: _ . _ _
        11'b11111110101: a_to_g[23:16] <= dah; // Z: _ _ . .

        11'b00100000110: a_to_g[15:8] <= dit; // B: _ . . .
        11'b00010000110: a_to_g[15:8] <= dah; // C: _ . _ .
        11'b00001000110: a_to_g[15:8] <= dit; // D: _ . .
        11'b00000010110: a_to_g[15:8] <= dah; // F: . . _ .
        11'b00000001110: a_to_g[15:8] <= dit; // G: _ _ .

        11'b00111111110: a_to_g[15:8] <= dit; // H: . . . .
        11'b01101111110: a_to_g[15:8] <= dah; // J: . _ _ _
        11'b01110111110: a_to_g[15:8] <= dah; // K: _ . _
        11'b01111011110: a_to_g[15:8] <= dit; // L: . _ . .

        11'b11000000110: a_to_g[15:8] <= dah; // O: _ _ _
        11'b10100000110: a_to_g[15:8] <= dah; // P: . _ _ .
        11'b10010000110: a_to_g[15:8] <= dit; // Q: _ _ . _
        11'b10000100110: a_to_g[15:8] <= dit; // R: . _ .
        11'b10000010110: a_to_g[15:8] <= dit; // S: . . .

        11'b10111111110: a_to_g[15:8] <= dah; // U: . . _
        11'b11011111110: a_to_g[15:8] <= dit; // V: . . . _
        11'b11101111110: a_to_g[15:8] <= dah; // W: . _ _
        11'b11111011110: a_to_g[15:8] <= dit; // X: _ . . _
        11'b11111101110: a_to_g[15:8] <= dah; // Y: _ . _ _
        11'b11111110110: a_to_g[15:8] <= dit; // Z: _ _ . .

        11'b00100000111: a_to_g[7:0] <= dit; // B: _ . . .
        11'b00010000111: a_to_g[7:0] <= dit; // C: _ . _ .
        11'b00000010111: a_to_g[7:0] <= dit; // F: . . _ .

        11'b00111111111: a_to_g[7:0] <= dit; // H: . . . .
        11'b01101111111: a_to_g[7:0] <= dah; // J: . _ _ _
        11'b01111011111: a_to_g[7:0] <= dit; // L: . _ . .

        11'b10100000111: a_to_g[7:0] <= dit; // P: . _ _ .
        11'b10010000111: a_to_g[7:0] <= dah; // Q: _ _ . _

        11'b11011111111: a_to_g[7:0] <= dah; // V: . . . _
        11'b11111011111: a_to_g[7:0] <= dah; // X: _ . . _
        11'b11111101111: a_to_g[7:0] <= dah; // Y: _ . _ _
        11'b11111110111: a_to_g[7:0] <= dit; // Z: _ _ . .
        default: begin
            a_to_g[31:24] <= null; // null
            a_to_g[23:16] <= null; // null
            a_to_g[15:8] <= null; // null
            a_to_g[7:0] <= null; // null
        end
    endcase
end
endmodule