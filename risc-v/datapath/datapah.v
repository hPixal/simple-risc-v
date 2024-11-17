`include "../risc-v-defines.v"
`include "../alu/alu.v"
`include "../control_unit/control_unit.v"
`include "../register_file/reg_file.v"
`include "../imm_gen/imm_gen.v"
`include "../csr/csr.v"
`include "../dmem/dmem.v"
`include "../program_counter/pc.v"
`include "../instr_mem/imem.v"

`include "../adders/adder_32.v"
`include "../muxes/mu2_32.v"
`include "../muxes/mu4_32.v"
`include "../muxes/mu2_16.v"



module datapath(
    input wire clk,
    input wire rst,
    output wire [31:0] pc_out
);

    // Control Signals
    wire reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump;
    wire [2:0] alu_op;

    // Connections for PC
    wire [31:0] next_pc, pc_plus_4, pc_branch, instruction;

    // Instruction memory
    wire [6:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7;

    // Register file connections
    wire [31:0] reg_data1, reg_data2, write_data;

    // ALU connections
    wire [31:0] alu_in2, alu_result;
    wire alu_zero;

    // Immediate Generator connections
    wire [31:0] imm_out;

    // Data memory connections
    wire [31:0] mem_data;

    // CSR connections
    wire [31:0] csr_data;

    // Program Counter
    pc program_counter (
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .next_pc(next_pc),
        .pc_out(pc_out)
    );

    // Adder for PC + 4
    adder_32 pc_increment (
        .op1(pc_out),
        .op2(32'd4),
        .res(pc_plus_4)
    );

    // Instruction Memory
    imem instruction_memory (
        .addr(pc_out),
        .instruction(instruction)
    );

    // Instruction decoding
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    assign rd = instruction[11:7];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];

    // Control Unit
    control_unit ctrl (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .zero(alu_zero),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );

    // Register File
    reg_file reg_file_inst (
        .clk(clk),
        .we(reg_write),
        .rst(rst),
        .ra1(rs1),
        .ra2(rs2),
        .wa(rd),
        .wd(write_data),
        .rd1(reg_data1),
        .rd2(reg_data2)
    );

    // Immediate Generator
    imm_gen imm_generator (
        .instr(instruction),
        .imm_sel(funct3),
        .imm_out(imm_out)
    );

    // ALU input multiplexer
    mu2_32 alu_mux (
        .e1(reg_data2),
        .e2(imm_out),
        .sel(alu_src),
        .sal(alu_in2)
    );

    // ALU
    alu alu_unit (
        .clk(clk),
        .rst(rst),
        .op(alu_op),
        .in_a(reg_data1),
        .in_b(alu_in2),
        .out_s(alu_result)
    );

    assign alu_zero = (alu_result == 32'b0);

    // Data Memory
    dmem data_memory (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result),
        .write_data(reg_data2),
        .read_data(mem_data)
    );

    // Data Memory or ALU Result to Write Data
    mu2_32 data_or_alu (
        .e1(alu_result),
        .e2(mem_data),
        .sel(mem_to_reg),
        .sal(write_data)
    );

    // Branch/Jump Logic
    wire [31:0] branch_target;
    adder_32 branch_adder (
        .op1(pc_out),
        .op2(imm_out),
        .res(branch_target)
    );

    mu4_32 pc_mux (
        .e1(pc_plus_4),
        .e2(branch_target),
        .e3(reg_data1), // For JALR
        .e4(32'b0),     // Unused
        .sel({jump, branch & alu_zero}),
        .sal(next_pc)
    );

    // CSR Unit
    csr csr_unit (
        .clk(clk),
        .rst(rst),
        .csr_write(reg_write && (opcode == 7'b1110011)), // CSR write condition
        .csr_read(1'b1),
        .csr_addr(instruction[31:20]),
        .csr_write_data(reg_data1),
        .csr_read_data(csr_data)
    );

endmodule
