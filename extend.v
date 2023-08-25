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


module extend(
//compulsory input
    input [31:0] ex_in,
    input [2:0] imm_src,
//compulsory output
    output reg [31:0] imm_ext
// my inout
    );
    reg [31:0] holder0, holder1, holder2, holder3, holder4, holder5;
    
    always@(*) begin
        holder0 =  {{20{ex_in[31]}},ex_in[31:20]};
        holder1 =  {{18{ex_in[31]}},ex_in[31:25],ex_in[11:7],2'b00};
        holder2 =  {{20{ex_in[31]}},ex_in[7],ex_in[30:25],ex_in[11:8],1'b0}; 
        holder3 =  {{12{ex_in[31]}},ex_in[19:12],ex_in[20],ex_in[30:21],1'b0};; 
        holder4 =  {ex_in[31:12],{12{1'b0}}}; 
        holder5 =  {ex_in[20],ex_in[19:12],ex_in[11],ex_in[19:12],{11{1'b0}}}; 
        case(imm_src)
            0: begin
                imm_ext = {{20{ex_in[31]}},ex_in[31:20]}; //I
            end
            1: begin
//                imm_ext = {{20{ex_in[31]}},ex_in[31:25],ex_in[11:7]}; //S
                imm_ext = {{18{ex_in[31]}},ex_in[31:25],ex_in[11:7],2'b00};
            end
            2: begin
                imm_ext = {{20{ex_in[31]}},ex_in[7],ex_in[30:25],ex_in[11:8],1'b0}; //B orjinali bu
//                imm_ext = {{25{ex_in[31]}},{ex_in[30:25]}}; //B
            end
            3: begin
                imm_ext = {{12{ex_in[31]}},ex_in[19:12],ex_in[20],ex_in[30:21],1'b0}; //J
//                imm_ext = {{12{ex_in[31]}},ex_in[20],ex_in[30:21],ex_in[19:12],1'b0}; //J
//                imm_ext = {{25{ex_in[31]}},{ex_in[11:7]}};
            end
            4: begin
                imm_ext = {ex_in[31:12],{12{1'b0}}}; //U
            end
            5: begin
                imm_ext = {ex_in[20],ex_in[19:12],ex_in[11],ex_in[19:12],{11{1'b0}}}; //J
            end
            6: begin
                imm_ext = {{12{ex_in[31]}},{ex_in[31:20]},{ex_in[11:7]},{ex_in[14:12]}}; //memory fill from cache
            end
        endcase
    end
    
endmodule
