`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 08:34:26
// Design Name: 
// Module Name: extend
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


module one_bit_multiplexer(
//compulsory input
    input [31:0]in_up,
    input [31:0]in_down,
    input control,
//compulsory output
    output reg [31:0]out
// my inout
    );
    
    always@(*)begin
        case (control)
            0: begin
                out = in_up;
            end
            1: begin
                out = in_down;
            end
        endcase
    end
    
    
    
endmodule