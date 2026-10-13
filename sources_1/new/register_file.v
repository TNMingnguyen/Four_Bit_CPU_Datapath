`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: register_file
// Description: 4 registers R0-R3, 4 bits each
//////////////////////////////////////////////////////////////////////////////////

module register_file (
  input  wire       clk,
  input  wire       rst,
  input  wire [1:0] ra,
  input  wire [1:0] rb,
  input  wire [1:0] wa,
  input  wire [3:0] wd,
  input  wire       we,
  output reg  [3:0] qa,
  output reg  [3:0] qb
);
  reg [3:0] r0, r1, r2, r3;

  // write port
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      r0 <= 4'd0;
      r1 <= 4'd0;
      r2 <= 4'd0;
      r3 <= 4'd0;
    end
    else if (we == 1'b1) begin
      case (wa)
        2'd0: r0 <= wd;
        2'd1: r1 <= wd;
        2'd2: r2 <= wd;
        2'd3: r3 <= wd;
      endcase
    end
  end

  // read port A
  always @(*) begin
    qa = (ra == 2'd0) ? r0 :
         (ra == 2'd1) ? r1 :
         (ra == 2'd2) ? r2 : r3;
  end

  // read port B
  always @(*) begin
    qb = (rb == 2'd0) ? r0 :
         (rb == 2'd1) ? r1 :
         (rb == 2'd2) ? r2 : r3;
  end
endmodule
