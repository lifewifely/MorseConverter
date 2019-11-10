`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Venci Freeman
//
// Create Date: 04/27/2019
// Design Name: switchitch Code-a_to_g Converter
// Module Name: top
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
module converter_top(clk, button0, button1, button2, button3, switch, LED, NUM, display, beep);

    input clk, button0, button1, button2, button3; // The button1 to button3 to control melody
    input [7:0]switch;
    output [3:0]NUM; // Control display
    output [7:0]display; // a.k.a. a_to_g
    output [7:0]LED; // Control LED
    output beep;

    wire [39:0] a_to_g;
    reg [31:0] freq;
    reg enable;
    reg [15:0] clk_cnt;
    reg [3:0] NUM;
    reg [7:0] display;

    // Melody definition
    parameter DO_L = 95602;
    parameter RE_L = 85179;
    parameter MI_L = 75872;
    parameter FA_L = 71633;
    parameter SO_L = 63376;
    parameter LA_L = 56818;
    parameter SI_L = 50607;
    parameter DO_M = 47801;
    parameter RE_M = 42589;
    parameter MI_M = 37936;
    parameter FA_M = 35791;
    parameter SO_M = 31887;
    parameter LA_M = 28409;
    parameter SI_M = 25419;
    parameter DO_H = 23886;
    parameter RE_H = 21267;
    parameter MI_H = 18939;
    parameter FA_H = 17876;
    parameter SO_H = 15924;
    parameter LA_H = 14184;
    parameter SI_H = 12637;

    assign LED[7] = switch[7];
    assign LED[6] = switch[6];
    assign LED[5] = switch[5];
    assign LED[4] = switch[4];
    assign LED[3] = switch[3];
    assign LED[2] = switch[2];
    assign LED[1] = switch[1];
    assign LED[0] = switch[0];

always @ (posedge clk) // Generate signal clk_cnt
    clk_cnt <= clk_cnt + 1;

always @ (posedge clk) begin// Control the display
    if(button0)
        case(clk_cnt[15:14])
            2'b00: begin
                NUM <= 4'b0111;
                display <= a_to_g[31:24];
            end
            2'b01: begin
                NUM <= 4'b1011;
                display <= a_to_g[23:16];
            end
            2'b10: begin
                NUM <= 4'b1101;
                display <= a_to_g[15:8];
            end
            2'b11: begin
                NUM <= 4'b1110;
                display <= a_to_g[7:0];
            end
        endcase
    else begin
        NUM <= 4'b0000;
        display <= a_to_g[39:32];
    end
end

always @ (*) begin // Control the buzzer
    case ({switch[6:0],button3,button2,button1})
        10'b1000000100: begin
            freq <= DO_L;
            enable <= 1;
        end
        10'b0100000100: begin
            freq <= RE_L;
            enable <= 1;
        end
        10'b0010000100: begin
            freq <= MI_L;
            enable <= 1;
        end
        10'b0001000100: begin
            freq <= FA_L;
            enable <= 1;
        end
        10'b0000100100: begin
            freq <= SO_L;
            enable <= 1;
        end
        10'b0000010100: begin
            freq <= LA_L;
            enable <= 1;
        end
        10'b0000001100: begin
            freq <= SI_L;
           enable <= 1;
        end
        10'b1000000010: begin
            freq <= DO_M;
            enable <= 1;
        end
        10'b0100000010: begin
            freq <= RE_M;
            enable <= 1;
        end
        10'b0010000010: begin
            freq <= MI_M;
            enable <= 1;
        end
        10'b0001000010: begin
            freq <= FA_M;
            enable <= 1;
        end
        10'b0000100010: begin
            freq <= SO_M;
            enable <= 1;
        end
        10'b0000010010: begin
            freq <= LA_M;
            enable <= 1;
        end
        10'b0000001010: begin
            freq <= SI_M;
            enable <= 1;
        end
        10'b1000000001: begin
            freq <= DO_H;
            enable <= 1;
        end
        10'b0100000001: begin
            freq <= RE_H;
            enable <= 1;
        end
        10'b0010000001: begin
            freq <= MI_H;
            enable <= 1;
        end
        10'b0001000001: begin
            freq <= FA_H;
            enable <= 1;
        end
        10'b0000100001: begin
            freq <= SO_H;
            enable <= 1;
        end
        10'b0000010001: begin
            freq <= LA_H;
            enable <= 1;
        end
        10'b0000001001: begin
            freq <= SI_H;
            enable <= 1;
        end
        default: begin
            freq <= 100;
            enable <= 0;
        end
    endcase
end

converter_sub PART1(.clk(clk),
                    .beep(beep),
                    .freq(freq),
                    .enable(enable),
                    .clk_cnt(clk_cnt),
                    .button0(button0),
                    .switch(switch),
                    .a_to_g(a_to_g)
                   );
endmodule