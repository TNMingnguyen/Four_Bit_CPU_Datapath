`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: instruction_register
// Description: IF/ID pipeline register (the IR)
//              Saves the fetched instruction, its address, and a valid bit
//////////////////////////////////////////////////////////////////////////////////

module instruction_register (
  input  wire        clk,
  input  wire        rst,
  input  wire        ir_load,
  input  wire        flush,
  input  wire [11:0] instruction_in,
  input  wire [3:0]  pc_in,
  output reg  [11:0] instruction_out,
  output reg  [3:0]  pc_out,
  output reg         valid_out
);
  always @(posedge clk) begin
    if (rst || flush) begin
      // reset or flush: load NOP (empty slot)
      instruction_out <= 12'hC00;
      pc_out          <= 4'd0;
      valid_out       <= 1'b0;
    end
    else if (ir_load) begin
      // normal load
      instruction_out <= instruction_in;
      pc_out          <= pc_in;
      valid_out       <= 1'b1;
    end
  end
endmodule