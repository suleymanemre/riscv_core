`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2023 14:04:00
// Design Name: 
// Module Name: cache_multiplexer
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


module cache_multiplexer(
    input clk,
    input reset,
    input [31:0] layer1,
    input [31:0] layer2,
    input miss,
    output reg [31:0] out,
    output reg save_to_cache
    );
    reg holder;
    always@(posedge clk) begin
        if (reset == 1) begin
            holder <= 0;
        end
        else begin
            holder <= miss;
        end
    end
    
    always@(*) begin
        if (reset == 1) begin
            save_to_cache = 0;
        end
        else begin
            if(holder == 0) begin
                out = layer1;
                save_to_cache = 0;
            end
            else begin
                out = layer2;
                save_to_cache = 1;
            end
        end
    end
endmodule
