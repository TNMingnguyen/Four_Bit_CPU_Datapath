`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: instruction_memory
// Description: 16 words x 12 bits instruction ROM, loaded from file
//////////////////////////////////////////////////////////////////////////////////

module instruction_memory #(
  parameter PROGRAM_FILE = "program.mem"
)(
  input  wire [3:0]  address,     // instruction address
  output wire [11:0] instruction  // instruction data
);
  reg [11:0] mem [0:15];          // 16 words, 12 bits each
  integer i;

  // fill all words with NOP first, then load program
  initial begin
    for (i = 0; i < 16; i = i + 1)
      mem[i] = 12'hC00;           // C00 = NOP (reserved opcode)
    $readmemh(PROGRAM_FILE, mem); // load program from file
  end

  // read is combinational (no clock needed)
  assign instruction = mem[address];
endmodule
