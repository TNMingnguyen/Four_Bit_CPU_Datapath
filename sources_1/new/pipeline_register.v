`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: pipeline_register
// Description: ID/EX pipeline register
//              Copies control signals + instruction fields from ID to EX
//////////////////////////////////////////////////////////////////////////////////

module pipeline_register (
  input  wire        clk,
  input  wire        rst,
  input  wire        flush,
  // inputs from ID stage
  input  wire [2:0]  alu_ctrl_in,
  input  wire        alu_src_sel_in,
  input  wire        wb_sel_in,
  input  wire        reg_we_in,
  input  wire        mem_we_in,
  input  wire        zero_we_in,
  input  wire        carry_we_in,
  input  wire        is_jmp_in,
  input  wire        is_jz_in,
  input  wire [1:0]  rd_in,
  input  wire [1:0]  rs_in,
  input  wire [3:0]  imm_in,
  input  wire [3:0]  pc_in,
  input  wire        valid_in,
  input  wire [11:0] instr_in,
  // outputs to EX stage
  output reg  [2:0]  alu_ctrl,
  output reg         alu_src_sel,
  output reg         wb_sel,
  output reg         reg_we,
  output reg         mem_we,
  output reg         zero_we,
  output reg         carry_we,
  output reg         is_jmp,
  output reg         is_jz,
  output reg  [1:0]  rd,
  output reg  [1:0]  rs,
  output reg  [3:0]  imm,
  output reg  [3:0]  pc,
  output reg         valid,
  output reg  [11:0] instr
);
  always @(posedge clk) begin
    if (rst || flush) begin
      // reset or flush: load bubble (all zero)
      alu_ctrl    <= 3'd0;
      alu_src_sel <= 1'b0;
      wb_sel      <= 1'b0;
      reg_we      <= 1'b0;
      mem_we      <= 1'b0;
      zero_we     <= 1'b0;
      carry_we    <= 1'b0;
      is_jmp      <= 1'b0;
      is_jz       <= 1'b0;
      rd          <= 2'd0;
      rs          <= 2'd0;
      imm         <= 4'd0;
      pc          <= 4'd0;
      valid       <= 1'b0;
      instr       <= 12'hC00;
    end
    else begin
      // normal: copy from ID
      alu_ctrl    <= alu_ctrl_in;
      alu_src_sel <= alu_src_sel_in;
      wb_sel      <= wb_sel_in;
      reg_we      <= reg_we_in;
      mem_we      <= mem_we_in;
      zero_we     <= zero_we_in;
      carry_we    <= carry_we_in;
      is_jmp      <= is_jmp_in;
      is_jz       <= is_jz_in;
      rd          <= rd_in;
      rs          <= rs_in;
      imm         <= imm_in;
      pc          <= pc_in;
      valid       <= valid_in;
      instr       <= instr_in;
    end
  end
endmodule