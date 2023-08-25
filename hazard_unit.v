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


module hazard_unit(
    //INPUT
    input clk,
    input reset,
    
    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] Rs2E,
    input [4:0] Rs1E,
    input PCSrcE,
    input [1:0] Result_SrcE,
    input [4:0] RdE,
    input [4:0] RdM,
    input [4:0] RdW,
    input RegWriteM,
    input RegWriteW,
    input [6:0] op,
    input branch_load_back,
    input branch_o,
    input miss,
    input call_from_memory,
    input call_from_memoryE,
    input call_from_memoryM,
    //OUTPUT
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output reg StallF,
    output reg StallD,
    output reg StallE,
    output reg StallM,
    output reg FlushD,
    output reg FlushE
    );
    reg lwStall;
    reg [6:0] opD,opE,opM,opW;
    always@(posedge clk) begin
        opD <= op;
        opE <= op;
        opM <= opE;
        opW <= opM;
    end
    
    
    always@(*) begin
        if (reset == 1) begin
            ForwardAE   = 0;
            ForwardBE   = 0;
            lwStall     = 0;
            StallF      = 0;
            StallD      = 0;
            StallE      = 0;
            StallM      = 0;
            FlushD      = 0;
            FlushE      = 0;
        end
        
        else begin
            
       
            //FORWARD A
            if (((Rs1E==RdM)&RegWriteM)&(Rs1E != 0)) begin
                ForwardAE = 2;
            end
            else if (((Rs1E==RdW)&RegWriteW)&(Rs1E != 0)) begin
                ForwardAE = 1;
            end
            else begin
                ForwardAE = 0;
            end
            //FORWARD B
            if (((Rs2E==RdM)&RegWriteM)&(Rs2E != 0)) begin
                ForwardBE = 2;
            end
            else if (((Rs2E==RdW)&RegWriteW)&(Rs2E != 0)) begin
                ForwardBE = 1;
            end
            else begin
                ForwardBE <= 0;
            end
            //STALL
            
            lwStall = Result_SrcE&((Rs1D == RdE)|(Rs2D == RdE));
           
            
            StallF = lwStall | miss;
            StallD = lwStall | miss;
            StallE = miss ;//& call_from_memoryM;
            StallM = miss ;//& call_from_memoryM;
            
            FlushD = PCSrcE | branch_load_back ;//| branch_o;
            FlushE = lwStall | PCSrcE | branch_load_back; //| branch_load_back;
        end
    end
    
endmodule
