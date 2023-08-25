`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 09:53:42
// Design Name: 
// Module Name: registerr
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


module registerr(
    input reset,
    input clk,
    input in_1,
    input in_2,
    input in_3,
    input in_4,
    output reg out1,
    output reg out2,
    output reg out3,
    output reg out4

    );
    
    
    always @(posedge clk) begin
        if (reset == 1)begin
            out1 <= 0;
            out2 <= 0;
            out3 <= 0;
            out4 <= 0;
        end
        else begin
            out1 <= in_1;
            out2 <= in_2;
            out3 <= in_3;
            out4 <= in_4;
        end
    end
endmodule
