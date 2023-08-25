`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2023 10:51:57
// Design Name: 
// Module Name: branch_predictor_pc_based
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


module branch_predictor_pc_based(
    input clk,
    input reset,
    input branch,
    input branch_delayed,
    input alu_branch,
    input [31:0] pc,
    input [31:0] pc_2,
    input branch_o_delayed,
    output reg branch_predict,
    output branch_load_back
    );
    parameter N = 256;
    reg [1:0] branch_mem [N:0];
    reg [1:0] branch_mem_2 [N:0];
    integer i;
    reg [7:0] global_history;
    reg [6:0]predict;
    reg bpredict;
    reg [6:0] any_holder;
    reg [6:0] any_holder2;
    reg [6:0] any_holder3;
    reg [6:0] any_holder4;
    reg predict_holder_gshare, predict_holder_bimodal;
//    assign branch_predict = branch & (branch_mem[pc_2] >= branch_mem[pc_2+1]);
    assign branch_load_back = (branch_o_delayed != alu_branch);
    
    
     always@(*) begin
        
        if (reset == 1) begin
            branch_predict = 0;
            bpredict = 0;
        end
        
        else if (branch == 0)begin
            branch_predict = 0;
            bpredict = 0;
        end
        
        else begin
            predict = branch_mem_2[ pc[6:0] | global_history[6:0] ];
            any_holder = pc[6:0];
            
            any_holder3 = pc[6:0] ^ global_history;
            
            if (predict == 0 | predict == 1) begin
                bpredict = 0;
            end    
            else begin
                bpredict = 1;
            end
            
            
            if (branch_mem[pc[6:0]] == 0 | branch_mem[pc[6:0]] == 1) begin
                branch_predict = 0;
            end    
            else begin
                branch_predict = 1;
            end
        end
    end  
    
    reg [6:0] branch_holder;
    integer gshare=0,bimodal=0,m=0;
    
    always@(posedge clk) begin
        any_holder2 <= any_holder3;
        branch_holder <= pc[6:0];
        predict_holder_gshare <= bpredict;
        predict_holder_bimodal <= branch_predict;
        
        if (branch_delayed == 1)begin
            if (alu_branch == predict_holder_gshare)begin
                gshare = gshare +1;
            end
            if (alu_branch == predict_holder_bimodal) begin
                bimodal = bimodal + 1;
            end
            m = m + 1;
        end
        
        
        if (reset == 1) begin
            global_history <= 0;
            
            for (i=0;i<N+1;i=i+1) begin
                branch_mem[i] <= 1;
                branch_mem_2[i] <= 1;
            end
        end
        else begin
            if (branch_delayed == 1) begin
                global_history <= {global_history[6:0],predict_holder_gshare};
                if (alu_branch == 1) begin
                    case(branch_mem[branch_holder])
                        2'b00: begin
                             branch_mem[branch_holder] <= 2'b01;
                             end
                        2'b01: begin 
                             branch_mem[branch_holder] <= 2'b10;
                             end
                        2'b10: begin
                             branch_mem[branch_holder] <= 2'b11;
                             end
                        2'b11: begin
                             branch_mem[branch_holder] <= 2'b11;
                             end
                    endcase
                    case(branch_mem_2[any_holder2])
                        2'b00: begin
                             branch_mem_2[any_holder2] <= 2'b01;
                             end
                        2'b01: begin 
                             branch_mem_2[any_holder2] <= 2'b10;
                             end
                        2'b10: begin
                             branch_mem_2[any_holder2] <= 2'b11;
                             end
                        2'b11: begin
                             branch_mem_2[any_holder2] <= 2'b11;
                             end
                    endcase
                end
                else begin
                      case(branch_mem[branch_holder])
                        2'b00: begin 
                            branch_mem[branch_holder] <= 2'b00;
                            end
                        2'b01: begin 
                            branch_mem[branch_holder] <= 2'b00;
                            end
                        2'b10: begin 
                            branch_mem[branch_holder] <= 2'b01;
                            end
                        2'b11: begin 
                            branch_mem[branch_holder] <= 2'b10; 
                            end
                    endcase
                    case(branch_mem_2[any_holder2])
                        2'b00: begin 
                            branch_mem_2[any_holder2] <= 2'b00;
                            end
                        2'b01: begin 
                            branch_mem_2[any_holder2] <= 2'b00;
                            end
                        2'b10: begin 
                            branch_mem_2[any_holder2] <= 2'b01;
                            end
                        2'b11: begin 
                            branch_mem_2[any_holder2] <= 2'b10; 
                            end
                    endcase
                end  
            end
            else begin
                
            end
        end
    end
endmodule
