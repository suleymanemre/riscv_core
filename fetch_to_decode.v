`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2023 09:04:20
// Design Name: 
// Module Name: execute_to_memory
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


module fetch_to_decode(
    //INPUT
    input clk,
    input reset,
    input StallD,
    input FlushD,
    input [31:0] instr,
    input [31:0] pc_plus,
    input [31:0] pcf,
    //OUTPUT
    output reg [31:0]instr_o,
    output reg [31:0]pc_plus_o,
    output reg [31:0]pcf_o
    );
    always@(posedge clk) begin
        if (reset == 1 | FlushD == 1) begin
            instr_o <= 0;
            pc_plus_o <= 0;
            pcf_o <= 0;
        end
        else begin
            if (StallD == 0) begin
                instr_o <= instr;
                pc_plus_o <= pc_plus;
                pcf_o <= pcf;
            end
            else begin
                //Sabit kalacak
            end
        end
    end
endmodule
