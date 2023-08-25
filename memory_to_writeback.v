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


module memory_to_writeback(
    //INPUT
    input clk,
    input reset,
    
    input reg_write,
    input [1:0] result_src,
    input [31:0] alu_result,
    input [31:0] read_data,
    input [4:0] rdM,
    input [31:0] pc_plus,
    input [31:0] pc_target_wire,
    //OUTPUT
    output reg reg_write_o,
    output reg [1:0] result_src_o,
    output reg [31:0] alu_result_o,
    output reg [31:0] read_data_o,
    output reg [4:0] rdM_o,
    output reg [31:0] pc_plus_o,
    output reg [31:0] pc_target_wire_o
    );
    
    always@(posedge clk) begin
        if (reset == 1) begin
            reg_write_o <= 0;
            result_src_o <= 0;
            alu_result_o <= 0;
            read_data_o <= 0;
            rdM_o <= 0;
            pc_plus_o <= 0;
            pc_target_wire_o <= 0; 
        end
        else begin
            reg_write_o <= reg_write;
            result_src_o <= result_src;
            alu_result_o <= alu_result;
            read_data_o <= read_data;
            rdM_o <= rdM;
            pc_plus_o <=  pc_plus;
            pc_target_wire_o <= pc_target_wire;
        end
    end
endmodule
