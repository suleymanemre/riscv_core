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


module execute_to_memory(
    //INPUT
    input clk,
    input reset,
    
    input reg_write,
    input [1:0] result_src,
    input [3:0] mem_write,
    input [31:0] alu_result,
    input [31:0] write_data,
    input [4:0] rdE,
    input [31:0] pc_plus,
    input [31:0] pc_target_wire,
    input target_choose,
    input StallM,
    input call_from_memory,
    //OUTPUT
    output reg reg_write_o,
    output reg [1:0]  result_src_o,
    output reg [3:0]  mem_write_o,
    output reg [31:0] alu_result_o,
    output reg [31:0] write_data_o,
    output reg [4:0] rdE_o,
    output reg [31:0] pc_plus_o,
    output reg [31:0] pc_target_wire_o,
    output reg target_choose_o,
    output call_from_memory_o
    );
    
    always@(posedge clk) begin
        if (reset == 1) begin
            reg_write_o <= 0;
            result_src_o <= 0;
            mem_write_o <= 0;
            alu_result_o <= 0;
            write_data_o <= 0;
            rdE_o <= 0;
            pc_plus_o <= 0;
            pc_target_wire_o <= 0;
            target_choose_o <= 0;        
        end
        else begin
            if(StallM == 0)begin
                reg_write_o <= reg_write;
                result_src_o <= result_src;
                mem_write_o <= mem_write;
                alu_result_o <= alu_result;
                write_data_o <= write_data;
                rdE_o <= rdE;
                pc_plus_o <= pc_plus;
                pc_target_wire_o <= pc_target_wire;
                target_choose_o <= target_choose;
            end
        end
    end
endmodule
