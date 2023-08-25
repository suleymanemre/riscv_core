`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 10:29:29
// Design Name: 
// Module Name: two_bit_multiplexer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module two_bit_multiplexer(
//compulsory input
    input [31:0]in_1,
    input [31:0]in_2,
    input [31:0]in_3,
    input [31:0]in_4,
    input [1:0] control,
//compulsory output
    output reg [31:0]out,
// my inout
    input reset
    );
    always@(*) begin
        if (reset == 1) begin
            out = 0;
        end
        else begin
            case(control)
                0: begin
                    out = in_1;
                end
                1: begin
                    out = in_2;
                end
                2: begin
                    out = in_3;
                end
                3: begin
                    out = in_4;
                end
            endcase
        end
    
    end
endmodule
