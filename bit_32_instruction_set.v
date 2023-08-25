`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2023 14:12:00
// Design Name: 
// Module Name: bit_32_instruction_set
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


module bit_32_instruction_set(

    );
    reg [31:0] mem [511:0];
    parameter reg00 = 5'b00000; parameter reg01 = 5'b00001; parameter reg02 = 5'b00010; parameter reg03 = 5'b00011;
    parameter reg04 = 5'b00100; parameter reg05 = 5'b00101; parameter reg06 = 5'b00110; parameter reg07 = 5'b00111;
    parameter reg08 = 5'b01000; parameter reg09 = 5'b01001; parameter reg10 = 5'b01010; parameter reg11 = 5'b01011;
    parameter reg12 = 5'b01100; parameter reg13 = 5'b01101; parameter reg14 = 5'b01110; parameter reg15 = 5'b01111;
    parameter reg16 = 5'b10000; parameter reg17 = 5'b10001; parameter reg18 = 5'b10010; parameter reg19 = 5'b10011;
    parameter reg20 = 5'b10100; parameter reg21 = 5'b10101; parameter reg22 = 5'b10110; parameter reg23 = 5'b10111;
    parameter reg24 = 5'b11000; parameter reg25 = 5'b11001; parameter reg26 = 5'b11010; parameter reg27 = 5'b11011;
    parameter reg28 = 5'b11100; parameter reg29 = 5'b11101; parameter reg30 = 5'b11110; parameter reg31 = 5'b11111;
    
    parameter opb = 7'b1100011; //branch operation
    parameter ops = 7'b0100011; //store operation
    parameter opl = 7'b0000011; //load operation
    parameter opz = 7'b0110011; //add sub vesaire
    parameter opi = 7'b0010011; //addi subi immediate i�in
    parameter jlr = 7'b1100111; //jalr
    parameter jal = 7'b1101111; //jal
    parameter lui = 7'b0110111; //lui
    parameter aui = 7'b0010111; //auipc
    
    initial begin
                      // inst        rs2         rs1      func3      rd(a3)       op
        mem [100] = {{7'b0000000},{5'b10001},{5'b10000},{3'b000},{5'b10010},{opb}}; //beq 18
        mem [101] = {{7'b0000000},{5'b10001},{5'b10001},{3'b000},{5'b10010},{opb}}; //beq 18
        
        mem [104] = {{7'b0000000},{5'b10001},{5'b10000},{3'b001},{5'b10010},{opb}}; //bne 18
        mem [105] = {{7'b0000000},{5'b10001},{5'b10001},{3'b001},{5'b10010},{opb}}; //bne 18
                                                                            
        mem [108] = {{7'b0000000},{5'b10001},{5'b10000},{3'b100},{5'b10010},{opb}}; //blt 18
        mem [109] = {{7'b0000000},{5'b10000},{5'b10001},{3'b100},{5'b10010},{opb}}; //blt 18
        mem [110] = {{7'b0000000},{5'b10001},{5'b10001},{3'b100},{5'b10010},{opb}}; //blt 18
                                                                             
        mem [112] = {{7'b0000000},{5'b10001},{5'b10000},{3'b101},{5'b10010},{opb}}; //bge 18
        mem [113] = {{7'b0000000},{5'b10000},{5'b10001},{3'b101},{5'b10010},{opb}}; //bge 18
        mem [114] = {{7'b0000000},{5'b10001},{5'b10001},{3'b101},{5'b10010},{opb}}; //bge 18
                                                                           
        mem [116] = {{7'b0000000},{5'b10001},{5'b10000},{3'b110},{5'b10010},{opb}}; //bltu 18
        mem [117] = {{7'b0000000},{5'b10000},{5'b10001},{3'b110},{5'b10010},{opb}}; //bltu 18
        mem [118] = {{7'b0000000},{5'b10001},{5'b10001},{3'b110},{5'b10010},{opb}}; //bltu 18
                                                                            
        mem [120] = {{7'b0000000},{5'b10001},{5'b10000},{3'b111},{5'b10010},{opb}}; //bgeu 18
        mem [121] = {{7'b0000000},{5'b10000},{5'b10001},{3'b111},{5'b10010},{opb}}; //bgeu 18
        mem [122] = {{7'b0000000},{5'b10001},{5'b10001},{3'b111},{5'b10010},{opb}}; //bgeu 18
        
        //              inst        rs2         rs1      func3      rd(a3)       op
        mem [190] = {{7'b0000000},{5'b01010},{5'b01001},{3'b000},{5'b00000},{ops}}; //sb 0
        mem [194] = {{7'b0000000},{5'b01011},{5'b01001},{3'b001},{5'b00000},{ops}}; //sh 0
        mem [198] = {{7'b0000000},{5'b01100},{5'b01001},{3'b010},{5'b00000},{ops}}; //sw 0
        
        //              inst               rs1      func3      rd(a3)       op
        mem [230] = {{12'b000000000000},{5'b01001},{3'b000},{5'b11111},{opl}}; //lb 31
        mem [234] = {{12'b000000000000},{5'b01001},{3'b001},{5'b11111},{opl}}; //lh 31
        mem [238] = {{12'b000000000000},{5'b01001},{3'b010},{5'b11111},{opl}}; //lw 31
        mem [242] = {{12'b000000000000},{5'b01001},{3'b100},{5'b11111},{opl}}; //lbu 31
        mem [246] = {{12'b000000000000},{5'b01001},{3'b101},{5'b11111},{opl}}; //lhu 31
        
        //              inst        rs2         rs1      func3      rd(a3)       op  
        mem [260] = {{7'b0000000},{5'b00011},{5'b00100},{3'b000},{5'b11110},{opz}}; //add 30
        mem [264] = {{7'b0100000},{5'b00011},{5'b00100},{3'b000},{5'b11101},{opz}}; //sub 29
        mem [268] = {{7'b0000000},{5'b00011},{5'b00100},{3'b001},{5'b11100},{opz}}; //shift left logical 28
        mem [272] = {{7'b0000000},{5'b00011},{5'b00100},{3'b010},{5'b11011},{opz}}; //set less than 27
        mem [276] = {{7'b0000000},{5'b00011},{5'b00100},{3'b011},{5'b11010},{opz}}; //set less than unsigned 26
        mem [280] = {{7'b0000000},{5'b00011},{5'b00100},{3'b100},{5'b11001},{opz}}; //xor 25
        mem [284] = {{7'b0000000},{5'b00011},{5'b00100},{3'b101},{5'b11000},{opz}}; //shift right logical 24
        mem [288] = {{7'b0100000},{5'b00011},{5'b00100},{3'b101},{5'b10111},{opz}}; //shift right arithmetic 23
        mem [292] = {{7'b0000000},{5'b00011},{5'b00100},{3'b110},{5'b10110},{opz}}; //or 22
        mem [296] = {{7'b0000000},{5'b00011},{5'b00100},{3'b111},{5'b10101},{opz}}; //and 21
        
        //              inst               rs1      func3      rd(a3)       op
        mem [310] = {{12'b000000000001},{5'b00100},{3'b000},{5'b11110},{opi}}; //addi 30
        mem [314] = {{12'b000000000001},{5'b00100},{3'b001},{5'b11100},{opi}}; //slli 28
        mem [318] = {{12'b000000000001},{5'b00100},{3'b010},{5'b11011},{opi}}; //slti 27
        mem [322] = {{12'b000000000001},{5'b00100},{3'b011},{5'b11010},{opi}}; //sltiu 26
        mem [326] = {{12'b000000000001},{5'b00100},{3'b100},{5'b11001},{opi}}; //xori 25
        mem [330] = {{12'b000000000001},{5'b00100},{3'b101},{5'b11000},{opi}}; //srli 24
        mem [334] = {{12'b010000000001},{5'b00100},{3'b101},{5'b10111},{opi}}; //srai 23
        mem [338] = {{12'b000000000001},{5'b00100},{3'b110},{5'b10110},{opi}}; //ori 22
        mem [342] = {{12'b000000000001},{5'b00100},{3'b111},{5'b10101},{opi}}; //andi 21
        
        //                  instr                   rd          op
        mem [360] = {{20'b00000000000000001000},{5'b10100},{aui}}; //auipc 20
        mem [364] = {{20'b00000000000000001000},{5'b10011},{lui}}; //lui 19                                                         
        
        //              inst               rs1      func3      rd(a3)       op
        mem [380] = {{12'b000000001000},{5'b00100},{3'b000},{5'b01111},{jlr}}; //jalr 15
        
        //                  instr                   rd          op
        mem [390] = {{20'b00000000000000011000},{5'b01110},{jal}}; //jal 14
        
        
        //        mem [  0] = {{7'b0000000},{reg03}, {reg04},{3'b000},{reg30},{opz}}; //add 30        
//        mem [  1] = {{12'b000000011111},   {reg31},{3'b010},{reg29},{opl}}; //lw 31
//        mem [  2] = {{7'b0000000},{reg30}, {reg29},{3'b000},{reg30},{opz}}; //add 30
//        mem [  3] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{opz}}; //add 30  
//        mem [  4] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [  5] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [  6] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [  7] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30 {{7'b0010100},{reg17}, {reg17},{3'b000},{reg00},{opb}}; //beq 00
//        mem [  8] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg20},{opz}}; //add 30
//        mem [  9] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30
//        mem [ 10] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30
//        mem [ 11] = {{7'b0000100},{reg12}, {reg05},{3'b010},{reg20},{ops}}; //sw 0
//        mem [ 12] = {{12'b000000000000},   {reg31},{3'b010},{reg28},{opl}}; //lw 31
//        mem [ 13] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30 
//        mem [ 14] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30 
//        mem [ 15] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{opz}}; //add 30  
//        mem [ 16] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 17] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 18] = {{20'b00000000000000001000},{reg00},{aui}}; //auipc 20
//        mem [ 19] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 20] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 21] = {{7'b0010100},{reg17}, {reg17},{3'b000},{reg00},{opb}}; //bne
//        mem [ 22] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 23] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 24] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 25] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 26] = {{7'b0010000},{reg17}, {reg17},{3'b001},{reg00},{opb}}; //bne
//        mem [ 27] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 28] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 29] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 30] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 31] = {{7'b0010000},{reg17}, {reg17},{3'b100},{reg00},{opb}}; //blt
//        mem [ 32] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 33] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 34] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 35] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 36] = {{7'b0010100},{reg01}, {reg17},{3'b000},{reg08},{opb}}; //bge
//        mem [ 37] = {{7'b0000000},{reg01}, {reg02},{3'b000},{reg01},{opz}}; //add 30
//        mem [ 38] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 39] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 40] = {{12'b000000000000},{reg07},{3'b000},{reg12},{jlr}}; //jalr 15
//        mem [ 41] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 42] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 43] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 44] = {{12'b000000000000},{5'b00000},{3'b000},{reg00},{jlr}}; //jalr 15
//        mem [ 45] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 46] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 47] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
        
             //NORMAL DENEME

//        mem [  0] = {{7'b0000000},{reg03}, {reg04},{3'b000},{reg30},{opz}}; //add 30        
//        mem [  4] = {{12'b000000000000},   {reg31},{3'b010},{reg29},{opl}}; //lw 31
//        mem [  8] = {{7'b0000000},{reg30}, {reg29},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 12] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{opz}}; //add 30  
//        mem [ 16] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 20] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 24] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 28] = {{7'b0010100},{reg17}, {reg17},{3'b000},{reg00},{opb}}; //beq 00
//        mem [ 32] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg20},{opz}}; //add 30
//        mem [ 36] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30
//        mem [ 40] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30
//        mem [ 44] = {{7'b0000000},{reg12}, {reg05},{3'b010},{reg20},{ops}}; //sw 0
//        mem [ 48] = {{12'b000000000000},   {reg31},{3'b010},{reg28},{opl}}; //lw 31
//        mem [ 52] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30 //{{12'b000000100000},   {reg00},{3'b000},{reg15},{jal}}; // jump to pre pc + 32
//        mem [ 56] = {{7'b0000000},{reg28}, {reg28},{3'b000},{reg29},{opz}}; //add 30 
//        mem [ 60] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{opz}}; //add 30  
//        mem [ 64] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 68] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 72] = {{20'b00000000000000001000},{reg00},{aui}}; //auipc 20
//        mem [ 76] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 80] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 84] = {{7'b0010100},{reg17}, {reg17},{3'b000},{reg00},{opb}}; //bne
//        mem [ 88] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 92] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [ 96] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [100] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [104] = {{7'b0010000},{reg17}, {reg17},{3'b001},{reg00},{opb}}; //bne
//        mem [108] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [112] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [116] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [120] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [124] = {{7'b0010000},{reg17}, {reg17},{3'b100},{reg00},{opb}}; //blt
//        mem [128] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [132] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [136] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [140] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
        
//        mem [144] = {{7'b0010100},{reg01}, {reg17},{3'b000},{reg08},{opb}}; //bge
//        mem [148] = {{7'b0000000},{reg01}, {reg02},{3'b000},{reg01},{opz}}; //add 30
        
//        mem [152] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [156] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [160] = {{12'b000000000000},{reg07},{3'b000},{reg12},{jlr}}; //jalr 15
//        mem [164] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [168] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [172] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [176] = {{12'b000000000000},{5'b00000},{3'b000},{reg00},{jlr}}; //jalr 15
//        mem [180] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [184] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [188] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
        
        //NORMAL DENEME SONU
//        mem [160] = {{20'b00000000000000001000},{reg00},{aui}}; //auipc 20
//        mem [164] = {{7'b0100000},{reg28}, {reg28},{3'b000},{reg28},{opz}}; //sub
//        mem [168] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [172] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [176] = {{7'b0010000},{reg17}, {reg17},{3'b001},{reg00},{opb}}; //bne
//        mem [180] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [184] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [188] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [192] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{opz}}; //add 30
//        mem [196] = {{12'b000000000000},{reg11},{3'b001},{reg14},{opl}}; //lh 31
//        mem [200] = {{7'b0000000},{reg14}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [204] = {{12'b000000000000},{reg11},{3'b000},{reg14},{opl}}; //lb 31
//        mem [208] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [212] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [216] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30 {{20'b00000000000000001000},{5'b10011},{7'b0110111}}; //lui 19
//        mem [220] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [224] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [228] = {{12'b000000000000},{5'b00000},{3'b000},{reg00},{jlr}}; //jalr 15
//        mem [232] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
//        mem [236] = {{7'b0000000},{reg15}, {reg14},{3'b000},{reg16},{opz}}; //add 30
        

        
        
        
//        //pipeline deneme
//        //              inst        rs2       rs1    func3    rd(a3)       op 
//        mem [400] = {{7'b0000000},{reg03}, {reg04},{3'b000},{reg30},{7'b0110011}}; //add 30
//        mem [401] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{7'b0110011}}; //add 30
//        mem [402] = {{7'b0000000},{reg30}, {reg04},{3'b000},{reg30},{7'b0110011}}; //add 30  
//        mem [403] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{7'b0110011}}; //add 30
//        mem [404] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{7'b0110011}}; //add 30
//        mem [405] = {{7'b0000000},{reg04}, {reg30},{3'b000},{reg30},{7'b0110011}}; //add 30
//        //              inst        rs2         rs1      func3      rd(a3)       op
//        mem [406] = {{7'b0000000},{reg12},{reg31},{3'b010},{reg31},{7'b0100011}}; //sw 0
//        //              inst              rs1     func3   rd(a3)       op
//        mem [407] = {{12'b000000000000},{reg31},{3'b010},{reg31},{7'b0000011}}; //lw 31    
       
//        mem [408] = {{7'b0000000},{reg17},{reg17},{3'b000},{reg18},{7'b1100011}}; //beq 18
    end
endmodule