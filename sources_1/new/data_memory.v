`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: data_memory
// Description: 16 words x 4 bits data RAM
//////////////////////////////////////////////////////////////////////////////////

module data_memory (
  input  wire       clk,
  input  wire [3:0] address,
  input  wire [3:0] write_data,
  input  wire       mem_we,
  output wire [3:0] read_data
);
  reg [3:0] mem [0:15];
  integer k;

  initial begin
    for (k = 0; k < 16; k = k + 1)
      mem[k] = 4'b0000;
  end

  always @(posedge clk) begin
    if (mem_we == 1'b1)
      mem[address] <= write_data;
  end

  assign read_data = mem[address];
endmodule