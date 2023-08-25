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


module decode_to_execute(
    //INPUT
    input clk,
    input reset,
    input FlushE,
    input reg_write,
    input [1:0] result_src,
    input [3:0] mem_write,
    input jump,
    input branch,
    input [6:0] alu_control,
    input alu_src,
    input [31:0] rd1,
    input [31:0] rd2,
    input [31:0] pc,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rdD,
    input [31:0] imm_ext,
    input [31:0] pc_plus,
    input [31:0] pc_target_wire_pre,
    input target_choose,
    input call_from_memory,
    input StallE,
    //OUTPUT
    output reg reg_write_o,
    output reg [1:0] result_src_o,
    output reg [3:0] mem_write_o,
    output reg jump_o,
    output reg branch_o,
    output reg [6:0] alu_control_o,
    output reg alu_src_o,
    output reg [31:0] rd1_o,
    output reg [31:0] rd2_o,
    output reg [31:0] pc_o,
    output reg [4:0] rs1_o,
    output reg [4:0] rs2_o,
    output reg [4:0] rdD_o,
    output reg [31:0] imm_ext_o,
    output reg [31:0] pc_plus_o,
    output reg [31:0] pc_target_wire,
    output reg target_choose_o,
    output reg call_from_memory_o
    );
    
    always@(posedge clk) begin
        if (reset == 1 | FlushE == 1) begin
            reg_write_o <= 0;
            result_src_o <= 0;
            mem_write_o <= 0;
            jump_o <= 0;
            branch_o <= 0;
            alu_control_o <= 0;
            alu_src_o <= 0;
            rd1_o <= 0;
            rd2_o <= 0;
            pc_o <= 0;
            rs1_o <= 0;
            rs2_o <= 0;
            rdD_o <= 0;
            imm_ext_o <= 0;
            pc_plus_o <= 0;
            pc_target_wire <= 0;
            target_choose_o <= 0;
            call_from_memory_o <= 0;
        end
        else begin
            if (StallE == 0) begin
                reg_write_o <= reg_write;
                result_src_o <= result_src;
                mem_write_o <= mem_write;
                jump_o <= jump;
                branch_o <= branch;
                alu_control_o <= alu_control;
                alu_src_o <= alu_src;
                rd1_o <= rd1;
                rd2_o <= rd2;
                pc_o <= pc;
                rs1_o <= rs1;
                rs2_o <= rs2;
                rdD_o <= rdD;
                imm_ext_o <= imm_ext;
                pc_plus_o <= pc_plus;
                pc_target_wire <= pc_target_wire_pre;
                target_choose_o <= target_choose;
                call_from_memory_o <= call_from_memory;
            end
        end
    end
endmodule
