`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2023 11:06:26
// Design Name: 
// Module Name: pc_adder_2
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


module pc_adder_2(
//compulsory input
    input [31:0] in_up,
    input [31:0] in_down,
//compulsory output
    output reg [31:0] out,
// my inout
    input reset
    );
    
    reg signed [31:0] srcA;
    reg signed [31:0] srcB;
    
    always @ (*) begin
        srcA = in_up;
        srcB = in_down;
        if (reset == 1) begin
            out = 0;
        end
        else begin
//            out = in_up + in_down;
            out = srcA + srcB;
        end
    end
endmodule
