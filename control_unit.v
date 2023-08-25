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


module control_unit(
//compulsory input
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input zero,
//compulsory output
    output reg pc_src, //target choose
    output reg [1:0] result_src,
    output reg [3:0] mem_write,
    output reg [6:0] alu_control,
    output reg alu_src,
    output reg [2:0] imm_src,
    output reg reg_write,
    output reg jump,
    output reg branch,
    output reg call_from_memory,
// my inout
    input reset
    );
    
    always@(*)begin
        if (reset == 1) begin
            pc_src = 0;          
            result_src = 0; 
            mem_write = 0;  
            alu_control = 0;
            alu_src = 0;          
            imm_src = 0;    
            reg_write = 0;       
            jump = 0;             
            branch = 0;
            call_from_memory = 0;
        end
        
        else begin       
        case(op)
            7'b0000000: begin
                result_src = 0;
                alu_src = 0;
                alu_control = 0;
                reg_write = 0;
                imm_src = 0;
                pc_src = 0;
                mem_write = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 0;
            end
            7'b0110111: begin //LUI
                result_src = 0;
                alu_src = 1;
                alu_control = 16;
                reg_write = 1;
                imm_src = 4;
                pc_src = 0;
                mem_write = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 0;
            end
            7'b0010111: begin //AUIPC
                imm_src = 4;
                pc_src = 0;
                reg_write = 1;
                mem_write = 0;
                result_src = 3;
                alu_control = 0; //x
                alu_src = 0; //x
                jump = 0;
                branch = 0;
                call_from_memory = 0;
            end
            7'b1101111: begin //JAL
                result_src = 2;
                imm_src = 3;
                pc_src = 1; // 0 idi deðiþtirdim 23 08 2023
                reg_write = 1;
                mem_write = 0;
                alu_control = 0; //x
                alu_src = 0; //x
                jump = 1;
                branch = 0;
                call_from_memory = 0;
            end
            7'b1100111: begin //JALR
                case(funct3)
                    3'b000: begin
                        imm_src = 0; 
                        alu_src = 1;
                        alu_control = 0; 
                        result_src = 2;
                        pc_src = 1;
                        reg_write = 1;
                        jump = 1;
                        branch = 0;
                        call_from_memory = 0;
                    end
                endcase     
            end
            7'b1100011: begin //BEQ BNE BLT BGE BLTU BGEU
                imm_src = 2; //B type 10 olacak
                reg_write = 1;
                alu_src = 0;
                mem_write = 0;
                result_src = 0; //x
                jump = 0;
                branch = 1;
                call_from_memory = 0;
                case(funct3)
                    3'b000: begin //BEQ
                        alu_control = 10;
                    end
                    3'b001: begin //BNE
                        alu_control = 11; 
                    end
                    3'b100: begin //BLT
                        alu_control = 12;
                    end
                    3'b101: begin //BGE
                        alu_control = 13; 
                    end
                    3'b110: begin //BLTU
                        alu_control = 14;
                    end
                    3'b111: begin //BGEU
                        alu_control = 15;
                    end
                endcase 
            end
            7'b0000011: begin //LB LH LW LBU LHU
                imm_src = 0; //I type 00 olacak
                reg_write = 1;
                alu_src = 1;
                result_src = 1;
                pc_src = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 1;
                case(funct3)
                    3'b000: begin //LB
                        alu_control = 0;
                        mem_write = 6;
                    end
                    3'b001: begin //LH
                        alu_control = 0;
                        mem_write = 5;
                    end
                    3'b010: begin //LW
                        alu_control = 0;
                        mem_write = 4;
                    end
                    3'b100: begin //LBU
                        alu_control = 0;
                        mem_write = 7;
                    end
                    3'b101: begin //LHU
                        alu_control = 0;
                        mem_write = 8;
                    end
                endcase 
            end
            7'b0100011: begin //SB SH SW
                imm_src = 1; //S type 01 olacak
                reg_write = 0;
                alu_src = 1;
                result_src = 1; //x
                pc_src = 0;
                alu_control = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 0;
                case(funct3)
                    3'b000: begin //SB
                        mem_write = 3; 
                    end
                    3'b001: begin //SH
                        mem_write = 2;
                    end
                    3'b010: begin //SW
                        mem_write = 1;
                    end
                endcase 
            end
            7'b0010011: begin //ADDI SLTI SLTIU XORI ORI ANDI SLLI SRLI SRAI
                reg_write = 1;
                imm_src = 0; 
                alu_src = 1;
                mem_write = 0;
                result_src = 0;
                pc_src = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 0;
                case(funct3)
                    3'b000: begin //ADDI
                        alu_control = 0;
                    end
                    3'b010: begin //SLTI
                        alu_control = 5;
                    end
                    3'b011: begin //SLTIU
                        alu_control = 7;
                    end
                    3'b100: begin //XORI
                        alu_control = 4;
                    end
                    3'b110: begin //ORI
                        alu_control = 3;
                    end
                    3'b111: begin //ANDI
                        alu_control = 2;
                    end
                    3'b001: begin //SLLI
                        alu_control = 6;
                    end
                    3'b101: begin //SRLI SRAI
                        case(funct7)
                        0: begin //SRLI
                            alu_control = 8;
                        end
                        1: begin //SRAI
                            alu_control = 9;
                        end
                        endcase
                    end
                endcase 
            end
            7'b0110011: begin  //ADD SUB SLL SLT SLTU XOR SRL SRA OR AND
                reg_write = 1;
                imm_src = 0; //xx
                alu_src = 0;
                mem_write = 0; 
                result_src = 0;
                pc_src = 0;
                jump = 0;
                branch = 0;
                call_from_memory = 0;
                case(funct3)
                    3'b000: begin //ADD SUB
                        case({op[5],funct7})
                            2'b00,2'b01,2'b10: begin //ADD
                                alu_control = 0;
                            end
                            2'b11: begin //SUB
                                alu_control = 1;
                            end
                        endcase
                    end
                    3'b001: begin // SLL
                        alu_control = 6;
                    end
                    3'b010: begin // SLT
                        alu_control = 5;
                    end
                    3'b011: begin // SLTU
                        alu_control = 7;
                    end
                    3'b100: begin // XOR
                        alu_control = 4;
                    end
                    3'b101: begin // SRL SRA
                        case (funct7)
                        0: begin //SRL
                            alu_control = 8;
                        end
                        1: begin //SRA  
                            alu_control = 9;    
                        end
                        endcase
                    end
                    3'b110: begin // OR
                        alu_control = 3;
                    end
                    3'b111: begin // AND
                        alu_control = 2;
                    end
                endcase 
            end
            7'b0000000: begin
                pc_src = 0;          
                result_src = 0; 
                mem_write = 0;  
                alu_control = 0;
                alu_src = 0;          
                imm_src = 0;    
                reg_write = 0;       
                jump = 0;             
                branch = 0;
                call_from_memory = 0;
            end
        endcase
    end //reset
    end
endmodule