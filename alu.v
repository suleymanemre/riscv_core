`timescale 1ns / 1ps


module alu#(parameter N=32)(
    //compulsory input
    input [31:0] srcA_us, //srcA
    input [31:0] srcB_us, //srcB
    input [6:0] alu_control,
    input [6:0] alu_control_1,
    //compulsory output
    output reg [31:0] alu_result,
    output reg zero,
    // my inout
    input clk,
    input reset
    );
    wire [31:0] sum, sub;
    reg signed [31:0] srcA;
    reg signed [31:0] srcB;
    reg signed [31:0] takip;
    
    
    always@(*) begin
    if (reset == 1) begin
        zero = 0;
        alu_result = 0;
    end
    else begin
        srcA = srcA_us;
        srcB = srcB_us;
        
        case(alu_control)
            0:begin //ADD
//                alu_result = sum;
//                alu_result = $signed(srcA+srcB);
                alu_result = (srcA+srcB);
                zero = 0;
            end
            1:begin //SUB
//                alu_result = sub;
//                if (srcB < 0) begin
//                    alu_result = (srcA+srcB);
//                end
//                else begin
                    alu_result = (srcA-srcB);
//                end
                zero = 0;
            end
            2:begin //AND
                alu_result = srcA & srcB;
                zero = 0;
            end
            3:begin //OR
                alu_result = srcA | srcB;
                zero = 0;
            end
            4:begin //XOR
                alu_result = srcA ^ srcB;
                zero = 0;
            end
            5:begin //SLT
                zero = 0;
                if (srcA < srcB)begin
                    alu_result = 1;
                end
                else begin
                    alu_result = 0;
                end
            end
            6:begin //SLL
                zero = 0;
                alu_result = srcA << srcB[4:0];
            end
            7:begin //SLTU
                zero = 0;
                if (srcA_us < srcB_us)begin
                    alu_result = 1;
                end
                else begin
                    alu_result = 0;
                end
            end
            8:begin //SRL
                zero = 0;
                alu_result = srcA >> srcB[4:0];
            end
            9:begin //SRA
                zero = 0;
                alu_result = srcA >>> srcB[4:0];
            end
            10:begin //BEQ
                if (srcA == srcB) begin
                    zero = 1;
                    alu_result = 1; 
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            11:begin //BNE
                if (srcA != srcB) begin
                    zero = 1;
                    alu_result = 1; 
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            12:begin //BLT
                if (srcA < srcB) begin
                    zero = 1; 
                    alu_result = 1;
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            13:begin //BGE
                if (srcA >= srcB) begin
                    zero = 1; 
                    alu_result = 1;
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            14:begin //BLTU
                if (srcA_us < srcB_us) begin
                    zero = 1; 
                    alu_result = 1;
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            15:begin // BGEU
                if (srcA_us >= srcB_us) begin
                    zero = 1; 
                    alu_result = 1;
                end
                else begin
                    zero = 0;
                    alu_result = 0;
                end
            end
            16:begin
                zero = 0;
                alu_result = srcB;
            end
            17:begin
                
            end
//            18:
//            19:
//            20:
//            21:
//            22:
//            23:
//            24:
//            25:
//            26:
//            27:
//            28:
//            29:
//            30:
//            31:
        endcase
        
    
    
    end // reset
    end
//    wire [32:0] carry_out;
//    wire [32:0] sub_out;
    
//    assign carry_out[0] = 0;
//    assign sub_out[0] = 0;
    
//    genvar i;
//        generate
//            for (i = 0; i<N ; i= i+1) begin
//                full_adder fa2 (.input_1(srcA[i]), .input_2(srcB[i]), .cin(carry_out[i]), .summation(sum[i]), .cout(carry_out[i+1]));
//                subtractor sub1 (.a(srcA[i]), .b(srcB[i]), .bin(sub_out[i]), .diff(sub[i]), .borrow(sub_out[i+1]));
//            end
//        endgenerate
endmodule


    
        
////FULL ADDER DELAY YOK
//module full_adder (input input_1, input_2, cin,
//                    output cout,
//                    output summation);
//    assign {cout ,summation} = input_1 + input_2 + cin;
//endmodule
    
// //SUB
//module subtractor (input a, b, bin,
//                    output borrow,
//                    output diff);
//    assign x = a^b;
//    assign y = (~x)&bin;
//    assign z = (~a)&b;
//    assign diff = x^bin;
//    assign borrow = y|z;
//endmodule   