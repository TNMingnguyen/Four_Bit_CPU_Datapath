`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: control_unit
// Description: Hardwired control unit
//              instruction_decoder (ID) + branch_unit (EX)
//////////////////////////////////////////////////////////////////////////////////

// instruction decoder (ID stage)
module instruction_decoder (
  input  wire [3:0] opcode,
  output reg  [2:0] alu_ctrl,
  output reg        alu_src_sel,
  output reg        wb_sel,
  output reg        reg_we,
  output reg        mem_we,
  output reg        zero_we,
  output reg        carry_we,
  output reg        is_jmp,
  output reg        is_jz
);
  // opcode values
  localparam OP_ADD   = 4'b0000;
  localparam OP_SUB   = 4'b0001;
  localparam OP_AND   = 4'b0010;
  localparam OP_OR    = 4'b0011;
  localparam OP_XOR   = 4'b0100;
  localparam OP_NOT   = 4'b0101;
  localparam OP_LDI   = 4'b0110;
  localparam OP_MOV   = 4'b0111;
  localparam OP_LOAD  = 4'b1000;
  localparam OP_STORE = 4'b1001;
  localparam OP_JMP   = 4'b1010;
  localparam OP_JZ    = 4'b1011;

  // ALU control codes
  localparam ALU_ADD  = 3'd0;
  localparam ALU_SUB  = 3'd1;
  localparam ALU_AND  = 3'd2;
  localparam ALU_OR   = 3'd3;
  localparam ALU_XOR  = 3'd4;
  localparam ALU_NOT  = 3'd5;
  localparam ALU_PASS = 3'd6;

  always @(*) begin
    // default: do nothing (NOP)
    alu_ctrl    = ALU_ADD;
    alu_src_sel = 1'b0;
    wb_sel      = 1'b0;
    reg_we      = 1'b0;
    mem_we      = 1'b0;
    zero_we     = 1'b0;
    carry_we    = 1'b0;
    is_jmp      = 1'b0;
    is_jz       = 1'b0;

    // use if/else instead of case
    if (opcode == OP_ADD) begin
      alu_ctrl = ALU_ADD;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
      carry_we = 1'b1;
    end
    else if (opcode == OP_SUB) begin
      alu_ctrl = ALU_SUB;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
      carry_we = 1'b1;
    end
    else if (opcode == OP_AND) begin
      alu_ctrl = ALU_AND;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
    end
    else if (opcode == OP_OR) begin
      alu_ctrl = ALU_OR;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
    end
    else if (opcode == OP_XOR) begin
      alu_ctrl = ALU_XOR;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
    end
    else if (opcode == OP_NOT) begin
      alu_ctrl = ALU_NOT;
      reg_we   = 1'b1;
      zero_we  = 1'b1;
    end
    else if (opcode == OP_LDI) begin
      alu_ctrl    = ALU_PASS;
      alu_src_sel = 1'b1;
      reg_we      = 1'b1;
    end
    else if (opcode == OP_MOV) begin
      alu_ctrl = ALU_PASS;
      reg_we   = 1'b1;
    end
    else if (opcode == OP_LOAD) begin
      alu_ctrl    = ALU_PASS;
      alu_src_sel = 1'b1;
      wb_sel      = 1'b1;
      reg_we      = 1'b1;
    end
    else if (opcode == OP_STORE) begin
      alu_ctrl    = ALU_PASS;
      alu_src_sel = 1'b1;
      mem_we      = 1'b1;
    end
    else if (opcode == OP_JMP)
      is_jmp = 1'b1;
    else if (opcode == OP_JZ)
      is_jz = 1'b1;
    // else: reserved opcode, keep defaults (NOP)
  end
endmodule

// branch unit (EX stage)
module branch_unit (
  input  wire is_jmp,
  input  wire is_jz,
  input  wire zero_flag,
  output reg  pc_sel,
  output wire flush
);
  always @(*) begin
    if (is_jmp == 1'b1)
      pc_sel = 1'b1;
    else if (is_jz == 1'b1 && zero_flag == 1'b1)
      pc_sel = 1'b1;
    else
      pc_sel = 1'b0;
  end

  assign flush = pc_sel;
endmodule

// main control unit
module control_unit (
  input  wire [3:0] opcode,
  output wire [2:0] alu_ctrl,
  output wire       alu_src_sel,
  output wire       wb_sel,
  output wire       reg_we,
  output wire       mem_we,
  output wire       zero_we,
  output wire       carry_we,
  output wire       is_jmp,
  output wire       is_jz,
  input  wire       ex_is_jmp,
  input  wire       ex_is_jz,
  input  wire       zero_flag,
  output wire       pc_sel,
  output wire       flush
);
  instruction_decoder DECODER (
    .opcode(opcode),
    .alu_ctrl(alu_ctrl),
    .alu_src_sel(alu_src_sel),
    .wb_sel(wb_sel),
    .reg_we(reg_we),
    .mem_we(mem_we),
    .zero_we(zero_we),
    .carry_we(carry_we),
    .is_jmp(is_jmp),
    .is_jz(is_jz)
  );

  branch_unit BRANCH (
    .is_jmp(ex_is_jmp),
    .is_jz(ex_is_jz),
    .zero_flag(zero_flag),
    .pc_sel(pc_sel),
    .flush(flush)
  );
endmodule