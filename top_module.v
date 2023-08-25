`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 08:31:30
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input reset,
    input [31:0] inn,
    output [31:0] outt
    );
    wire [31:0] SrcA,SrcB;
    wire [31:0] pc_wire;
    wire [31:0] pc_next_wire,pc_next_wire2;
    wire [31:0] instr_wire;
    wire [31:0] rd1_wire;
    wire [31:0] Alu_Carry;
    wire [31:0] srcb_wire;
    wire [31:0] rd2_wire;
    wire [31:0] imm_ext_wire;
    wire [31:0] alu_result_wire;
    wire [31:0] read_data_wire;
    wire [31:0] result_wire;
    wire [31:0] pc_plus_wire;
    wire [31:0] pc_target_wire, pc_target_wire_pre;
    wire zero;
    wire reg_write_wire;
    wire [2:0] imm_src_wire;
    wire alu_src_wire;
    wire [6:0] alu_control_wire;
    wire [3:0] mem_write_wire;
    wire [1:0] result_src_wire;
    wire  pc_src_wire;
    reg [31:0] pc_plus_adder = 4;
    
    //pipeline wires begin
    wire [31:0] PCF, PCD, PCE;
    wire [31:0] InstrF; //tamam
    wire [4:0] Rs1E,Rs2E; //tamam
    wire [4:0] RdE,RdM,RdW; //tamam
    wire [31:0] ImmExtE; //tamam
    wire [31:0] PcPlus4F, PcPlus4D, PcPlusE, PcPlusM, PcPlusW; //tamam
    wire [31:0] RD1E,RD2E; //tamam
    wire [31:0] WriteDataE,WriteDataM;
    wire [31:0] AluResultM, AluResultW; //tamam
    wire [31:0] ReadDataW; //tamam
    wire RegWriteE, RegWriteM, RegWriteW; //tamam
    wire JumpD, JumpE, BranchD, BranchE;
    wire [3:0] MemWriteE, MemWriteM; //tamam
    wire [1:0] Result_SrcE, Result_SrcM, Result_SrcW; //tamam
    wire Alu_srcE; //tamam
    wire [31:0] pc_targetM, pc_targetW;
    wire [1:0] ForwardBE, ForwardAE;
    wire StallF,StallD,StallE,StallM,FlushD,FlushE;
    wire target_choose,target_chooseE,target_chooseM;
    //pipeline wires end
    
    //branch prediction
    wire branch_o;
    wire [31:0] pc_wire_pre;
    wire branch_o_delay, branch_delayed;
    wire branch_load_back, branch_load_back_delayed;
    wire [31:0] pc_holder_for_branch_load_back, PCTar_reg_delay, PCPlus_reg_delay;
    wire pc_src_branch, zero_delay;
    
    // instruction compression
    wire compressed_or_not;
    wire [31:0] instruction_carry,instruction_carry_2;
    
    // Cache
    wire call_from_memory_wire, call_from_memory_wireE, call_from_memory_wireM;
    wire miss_wire;
    wire [31:0] cache_data_wire;
    wire [31:0] mainmem_result_wire;
    wire save_to_cache_wire;
    //FETCH

    jump_branch jbra (.jump(JumpE),.branch(branch_o),.zero(zero),.pc_src(pc_src_wire),.branch_o_delayed(branch_o_delay),.pc_src_branch(pc_src_branch));
    
    clk_pc_src_merge pc_src_all (.reset(reset),.clk(clk),.StallF(StallF),.pc_1(PcPlus4F),.pc_2(pc_target_wire),.pc_3(alu_result_wire),.pc_4(PCPlus_reg_delay),
                                 .pc_5(PCTar_reg_delay),.jump(JumpE),.branch_o(branch_o),.branch_o_delay(branch_o_delay),.target_choose(target_chooseE),.zero(zero),
                                 .zero_delay(zero_delay),.branch_load_back(branch_load_back),.pc_out(pc_wire));
    
    
    
    
//    clock clk_1 (.reset(reset),.StallF(StallF),.clk(clk),.pc_next(pc_next_wire2),.pc(pc_wire)); //clk merge comment out
    
    instruction_memory in_mem (.clk(clk),.reset(reset),.pc(pc_wire),.instr(instruction_carry),.compressed_or_not(compressed_or_not));
    
//    instruction_main_memory in_main_mem (.pc(pc_wire),.clk(clk),.reset(reset),.miss_cache(miss_cache),.instr_from_main_mem(instruction_carry_2));
    
//    instr_cache_L1 ins_cache (.cache_input(),.save_to_cache(instr_save),.miss_cache(miss_cache),.clk(clk),.reset(reset),.pc(pc_wire),.instr(instruction_carry));
    
//    cache_multiplexer ins_mult (.clk(clk),.layer1(instruction_carry),.layer2(instruction_carry_2),.miss(miss_cache),.out(),.save_to_cache(instr_save));
    
    instruction_decoder in_dec (.instr(instruction_carry),.compressed_or_not(compressed_or_not),.instr_o(InstrF));
    
    
    
    pc_adder pc_add_1 (.reset(reset),.in_up(pc_wire),.in_down(pc_plus_adder),.out(PcPlus4F),.compressed_or_not(compressed_or_not));
    
    
    fetch_to_decode f2d (.StallD(StallD),.FlushD(FlushD),.clk(clk),.reset(reset),.instr(InstrF),.instr_o(instr_wire),
                         .pc_plus(PcPlus4F),.pc_plus_o(PcPlus4D),.pcf(pc_wire),.pcf_o(PCD));
    
    //DECODE
    register_file reg_file (.clk(clk),.reset(reset),.a1(instr_wire[19:15]),.a2(instr_wire[24:20]),.a3(RdW),
                            .wd3(result_wire),.reg_write(RegWriteW),.rd1(rd1_wire),.rd2(rd2_wire));
    
    extend ext (.ex_in(instr_wire),.imm_src(imm_src_wire),.imm_ext(imm_ext_wire));
    
    control_unit c_unit (.reset(reset),.jump(JumpD),.branch(BranchD),.op(instr_wire[6:0]),.funct3(instr_wire[14:12]),.funct7(instr_wire[30]),
                        .zero(zero),.pc_src(target_choose),.result_src(result_src_wire),
                        .mem_write(mem_write_wire),.alu_control(alu_control_wire),.alu_src(alu_src_wire),
                        .imm_src(imm_src_wire),.reg_write(reg_write_wire),.call_from_memory(call_from_memory_wire));
         
    
    pc_adder_2 pc_add_2 (.reset(reset),.in_up(PCD),.in_down(imm_ext_wire),.out(pc_target_wire_pre));

    
    decode_to_execute d2e (.StallE(StallE),.FlushE(FlushE),.clk(clk),.reset(reset),.reg_write(reg_write_wire),.result_src(result_src_wire),.mem_write(mem_write_wire),.jump(JumpD),.branch(BranchD),
                            .alu_control(alu_control_wire),.alu_src(alu_src_wire),.rd1(rd1_wire),.rd2(rd2_wire),.pc(PCD),.rs1(instr_wire[19:15]),
                            .rs2(instr_wire[24:20]),.rdD(instr_wire[11:7]),.imm_ext(imm_ext_wire),.pc_plus(PcPlus4D),.pc_target_wire_pre(pc_target_wire_pre),.target_choose(target_choose),
                            .call_from_memory(call_from_memory_wire),
                            
                            .reg_write_o(RegWriteE),.result_src_o(Result_SrcE),.mem_write_o(MemWriteE),.jump_o(JumpE),.branch_o(BranchE),
                            .alu_control_o(Alu_Carry[6:0]),.alu_src_o(Alu_SrcE),.rd1_o(RD1E),.rd2_o(RD2E),.pc_o(PCE),.rs1_o(Rs1E),
                            .rs2_o(Rs2E),.rdD_o(RdE),.imm_ext_o(ImmExtE),.pc_plus_o(PcPlusE),.pc_target_wire(pc_target_wire),.target_choose_o(target_chooseE),
                            .call_from_memory_o(call_from_memory_wireE));
   
   

   
    //EXECUTE

    two_bit_multiplexer srca (.reset(reset),.in_1(RD1E),.in_2(result_wire),.in_3(AluResultM),.control(ForwardAE),.out(SrcA));
    
    two_bit_multiplexer w_data_e (.reset(reset),.in_1(RD2E),.in_2(result_wire),.in_3(AluResultM),.control(ForwardBE),.out(WriteDataE));
    
    one_bit_multiplexer alu_src_mult (.in_up(WriteDataE),.in_down(ImmExtE),.control(Alu_SrcE),.out(srcb_wire));
    
    alu alu1 (.reset(reset),.clk(clk),.srcA_us(SrcA),.srcB_us(srcb_wire),.alu_control(Alu_Carry[6:0]),
              .alu_control_1(alu_control_wire),.zero(zero),.alu_result(alu_result_wire));
    

    execute_to_memory e2m (.StallM(StallM),.clk(clk),.reset(reset),.reg_write(RegWriteE),.result_src(Result_SrcE),.mem_write(MemWriteE),.call_from_memory(call_from_memory_wireE),
                            .alu_result(alu_result_wire),.write_data(WriteDataE),.rdE(RdE),.pc_plus(PcPlusE),.pc_target_wire(pc_target_wire),.target_choose(target_chooseE),
                            
                            .reg_write_o(RegWriteM),.result_src_o(Result_SrcM),.mem_write_o(MemWriteM),.call_from_memory_o(call_from_memory_wireM),
                            .alu_result_o(AluResultM),.write_data_o(WriteDataM),.rdE_o(RdM),.pc_plus_o(PcPlusM),.pc_target_wire_o(pc_targetM),.target_choose_o(target_chooseM));
    
    //MEMORY
//    data_memory d_mem (.clk(clk),.reset(reset),.alu_result(AluResultM),.write_data(WriteDataM),.mem_write(MemWriteM),.read_data(read_data_wire));
    
    cache_L1 cache (.clk(clk),.reset(reset),.mem_write(MemWriteM),.write_data(WriteDataM),.alu_result(AluResultM),.miss(miss_wire),.read_data(cache_data_wire),.save_to_cache(save_to_cache_wire),.mainmem_result(mainmem_result_wire));
    
    main_memory m_mem (.clk(clk),.reset(reset),.alu_result(AluResultM),.out(mainmem_result_wire),.mem_write(MemWriteM),.write_data(WriteDataM));
    
    cache_multiplexer cmult (.clk(clk),.layer1(cache_data_wire),.layer2(mainmem_result_wire),.miss(miss_wire),.out(read_data_wire),.save_to_cache(save_to_cache_wire));
    
    memory_to_writeback m2w (.clk(clk),.reset(reset),.reg_write(RegWriteM),.result_src(Result_SrcM),.alu_result(AluResultM),
                             .read_data(read_data_wire),.rdM(RdM),.pc_plus(PcPlusM),.pc_target_wire(pc_targetM),
                             
                             .reg_write_o(RegWriteW),.result_src_o(Result_SrcW),.alu_result_o(AluResultW),
                             .read_data_o(ReadDataW),.rdM_o(RdW),.pc_plus_o(PcPlusW),.pc_target_wire_o(pc_targetW));
                             
    //WRITE BACK

    two_bit_multiplexer result_src_mult (.reset(reset),.in_1(AluResultW),.in_2(ReadDataW),.in_3(PcPlusW),.in_4(pc_targetW),.control(Result_SrcW),.out(result_wire));


    //HAZARD
    
    hazard_unit hunit (.clk(clk),.reset(reset),.op(instr_wire[6:0]),.branch_load_back(branch_load_back),.miss(miss_wire),
                       .StallF(StallF),.StallD(StallD),.StallE(StallE),.StallM(StallM),.FlushD(FlushD),.Rs1D(instr_wire[19:15]),.Rs2D(instr_wire[24:20]),.FlushE(FlushE),.RdE(RdE),.Rs2E(Rs2E),
                       .Rs1E(Rs1E),.PCSrcE(pc_src_wire),.ForwardAE(ForwardAE),.ForwardBE(ForwardBE),.call_from_memory(call_from_memory_wire),.call_from_memoryE(call_from_memory_wireE),.call_from_memoryM(call_from_memory_wireM),
                       .Result_SrcE(Result_SrcE),.RdM(RdM),.RegWriteM(RegWriteM),.RdW(RdW),.RegWriteW(RegWriteW),.branch_o(branch_o));
                       
                       
    //  BRANCH PREDICTION
    registerr regreg (.reset(reset),.clk(clk),.in_1(branch_o),.in_2(BranchD),.in_3(branch_load_back),.in_4(zero),.out1(branch_o_delay),.out2(branch_delayed),.out3(branch_load_back_delayed),.out4(zero_delay));
    
    pc_register pc_reg (.clk(clk),.reset(reset),.PCPlus4(PcPlus4D),.PCTarget(pc_target_wire_pre),.PCE(PCPlus_reg_delay),.PCTarE(PCTar_reg_delay),.branch_load_back(branch_load_back),.compressed_or_not(compressed_or_not));

    branch_predictor_pc_based bra_pre_pc_base (.clk(clk),.reset(reset),.branch(BranchD),.alu_branch(zero),.pc(PCD),.pc_2(pc_wire)
                                              ,.branch_delayed(branch_delayed),.branch_o_delayed(branch_o_delay),.branch_load_back(branch_load_back),.branch_predict(branch_o));
endmodule
