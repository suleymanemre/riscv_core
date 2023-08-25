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


module pc_adder(
//compulsory input
    input [31:0] in_up,
    input [31:0] in_down,
//compulsory output
    output reg [31:0] out,
// my inout
    input reset,
    input compressed_or_not,
    input instruction_pointer
    );
    
    parameter [31:0] start_point = 32'h8000006c;
    
    always @ (*) begin //V2
        if (reset == 1) begin
            out = start_point;
        end
        else begin
            if (compressed_or_not == 0) begin
                out = in_up + in_down;
            end
            else begin
                out = in_up + 2;
            end
        end
    end
    
//    always @ (*) begin //V1
//        if (reset == 1) begin
//            out = 0;
//        end
//        else begin
//            if (compressed_or_not == 0) begin
//                out = in_up + in_down;
//            end
//            else begin
//                if (instruction_pointer == 1) begin
//                    out = in_up + in_down;
//                end
//                else begin
//                    out = in_up;
//                end
//            end
//        end
//    end
endmodule