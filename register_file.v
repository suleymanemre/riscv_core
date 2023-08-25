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


module register_file(
//compulsory input
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    input [31:0] wd3,
    input reg_write,
//compulsory output
    output reg [31:0] rd1,
    output reg [31:0] rd2,
// my inout
    input reset,
    input clk
    );
    reg [31:0] mem [31:0];
    always@(posedge reset) begin
        mem[0]=    0; // 0;    //  //zero constant             zero
        mem[1]=    0; // 1;    //  //return address            ra
        mem[2]=    0; // 1;    //  //stack pointer             sp
        mem[3]=    0; // 3;    //  //global pointer            gp
        mem[4]=    0; // 4;    //  //thread pointer            tp
        mem[5]=    0; // 5;    //  //temporaries               t0
        mem[6]=    0; // 6;    //  //temporaries               t1
        mem[7]=    0; // 144;  //  //temporaries               t2
        mem[8]=    0; // 8;    //  //saved / frame pointer     s0
        mem[9]=    0; // 1;    //  //saved register            s1
        mem[10]=   0; // 10;   //  //fn args / return values   a0
        mem[11]=   0; // 11;   //  //fn args / return values   a1
        mem[12]=   0; // 12;   //  //fn args                   a2
        mem[13] =  0; // 13;   //  //fn args                   a3
        mem[14] =  0; // 14;   //  //fn args                   a4
        mem[15] =  0; // 15;   //  //fn args                   a5
        mem[16]=   0; // 16;   //  //fn args                   a6
        mem[17]=   0; // 5;    //  //fn args                   a7
        mem[18] =  0; // 18;   //  //saved register            s2
        mem[19] =  0; // 19;   //  //saved register            s3
        mem[20] =  0; // 20;   //  //saved register            s4
        mem[21] =  0; // 0;    // //saved register            s5
        mem[22] =  0; // 22;   //  //saved register            s6
        mem[23] =  0; // 23;   //  //saved register            s7
        mem[24] =  0; // 24;   //  //saved register            s8
        mem[25] =  0; // 25;   //  //saved register            s9
        mem[26] =  0; // 26;   //  //saved register            s10
        mem[27] =  0; // 27;   //  //saved register            s11
        mem[28] =  0; // 28;   //  //temporaries               t3
        mem[29] =  0; // 29;   //  //temporaries               t4
        mem[30] =  0; // 30;   //  //temporaries               t5
        mem[31] =  0; // 31;   //  //temporaries               t6
    end
    
    always@(*)begin
        rd2 = mem[a2];
        rd1 = mem[a1];
//        if (reg_write == 1) begin
//            mem[a3] = wd3;
//        end
    end
    
    always@(clk) begin
       
//        rd2 <= mem[a2];
//        rd1 <= mem[a1];
        if (reg_write == 1) begin
            if (a3 != 0) begin
                mem[a3] <= wd3;
            end
        end
    end
    
//    always@(posedge clk) begin
        
        
//        if (reg_write == 1) begin
//            mem[a3] = wd3;
//        end
//    end
endmodule