4-BIT RISC CPU WITH A 3-STAGE PIPELINE (Verilog HDL)
=====================================================

Stages:  IF (fetch)  ->  ID (decode)  ->  EX (execute + memory + write-back)
One instruction finishes every clock once the pipeline is full.
A taken jump (JMP, or JZ with Zero = 1) flushes 2 instructions (2 extra clocks).

DESIGN FILES - folder rtl/ (add as "design sources" in Vivado)
  alu.v                   ALU: adder_subtractor, logic_unit, zero_detector, alu
  register_file.v         4 registers R0-R3, 2 read ports, 1 write port
  program_counter.v       4-bit PC
  instruction_memory.v    16 x 12-bit program memory (loads a .mem file)
  instruction_register.v  IF/ID pipeline register (the IR)
  pipeline_register.v     ID/EX pipeline register
  control_unit.v          instruction_decoder (ID stage) + branch_unit (EX stage)
  data_memory.v           16 x 4-bit data memory
  mux.v                   2-input 4-bit multiplexer (used 3 times)
  flag_register.v         Zero and Carry flags
  cpu_top.v               TOP MODULE - connects everything, stage by stage

TESTBENCHES - folder testbench/ (add as "simulation sources", then "Set as Top" one at a time)
  tb_alu.v                ALU on its own            (11 tests)
  tb_register_file.v      register file on its own  (11 checks)
  tb_control_unit.v       decoder + branch unit     (22 checks)
  tb_cpu.v                complete CPU, 4 programs  (44 checks)

PROGRAM FILES - folder programs/ (also add as simulation sources, choose "All files")
  program.mem             demonstration program (project plan Appendix A)
  prog_arith.mem          ADD, SUB, STORE, LOAD, flags
  prog_logic.mem          AND, OR, XOR, MOV, NOT, LDI, Zero
  prog_jump.mem           PC increment, JMP, JZ taken / not taken

RUN
  Simulation -> Run Behavioral Simulation, then type:  run all
  Each testbench ends with a PASSED / FAILED summary line.

CARRY CONVENTION
  ADD: Carry = 1 when the sum does not fit in 4 bits.
  SUB: Carry = 1 means NO borrow (a >= b).

DOCUMENTS - folder docs/
  4bit_RISC_CPU_Pipeline_Report.pdf   full project report (theory + practical)
  code_explained/Explained_*.pdf      one walkthrough for EVERY Verilog file (15)

COMMENTS
  Every place where a file uses a module from another file has a comment
  "// CALLS: module X from file Y.v". Each file header has a CONNECTIONS
  list (Calls / Called by).
đây mới là file readme chuẩn tôi muốn sửa lại file readme phải làm sao
