`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2023 08:03:01
// Design Name: 
// Module Name: clk_pc_src_merge
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


module clk_pc_src_merge(
input clk,
input reset,
input [31:0] pc_1,
input [31:0] pc_2,
input [31:0] pc_3,
input [31:0] pc_4,
input [31:0] pc_5,
input StallF,
input jump,
input branch_o,branch_o_delay,
input zero,zero_delay,
input target_choose,
input branch_load_back,

output reg [31:0] pc_out
    );
    parameter [31:0] start_point = 32'h8000006c;
    
    always@(posedge clk) begin
        if (reset == 1) begin
            pc_out <= start_point;
        end
        else begin
            if (StallF == 1) begin
            
            end
            else begin
                if ((jump == 1 | (branch_o_delay == 1 & branch_load_back == 0)) & target_choose == 0)begin // burayý branch_o_delay olacak þekilde deðiþtiriyorum 1944. sütun
                    pc_out <= pc_2; //pc_target
                end
                else if (target_choose == 1 & jump ==1) begin
                    pc_out <= pc_2;
                end
                else if(target_choose == 1) begin
                    pc_out <= pc_3;
                end    
                else if(branch_load_back == 1 & zero == 0) begin
                    pc_out <= pc_4;
                end
                else if(branch_load_back == 1 & zero == 1) begin
                    pc_out <= pc_5;
                end
                else begin
                    pc_out <= pc_1; //pc+4
                end
            end
        end
    end
endmodule
