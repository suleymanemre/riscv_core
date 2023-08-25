`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 13:38:07
// Design Name: 
// Module Name: pc_register
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


module pc_register(
    input clk,
    input reset,
    input [31:0] PCPlus4,
    input [31:0] PCTarget,
    input branch_load_back,
    input compressed_or_not,
    
    output reg [31:0] PCE,
    output reg [31:0] PCTarE
    );
    reg [31:0] PCD,PCD1,PCD2,PCD3,PCTar,PCTar1,PCTar2,PCTar3;
    reg branch_holder;
    
    always @(posedge clk) begin
    if (reset) begin
        PCD <= 0;
        PCE <= 0;
        PCTar <= 0;
        PCTarE <= 0;
        end
    else begin
        branch_holder <= branch_load_back;
        if (branch_load_back == 0) begin
            if (branch_holder == 0) begin
               PCD <= PCPlus4;
               PCD1 <= PCD;
               PCD2 <= PCD1;
               PCD3 <= PCD2;
               PCE <= PCPlus4;//PCD;
               PCTar <= PCTarget;
               PCTar1 <= PCTar;
               PCTar2 <= PCTar1;
               PCTar3 <= PCTar2;
               PCTarE <= PCTarget;
            end
        end
    end
    end
endmodule
