# Four_Bit_CPU_Datapath

A 4-bit RISC CPU with a 3-stage pipeline (IF, ID, EX), designed in Verilog HDL.

## Features
- 4-bit RISC, load/store architecture
- 3-stage pipeline: IF (Fetch), ID (Decode), EX (Execute + Memory + Write-back)
- 12-bit instruction: 4-bit opcode, 2-bit Rd, 2-bit Rs, 4-bit immediate
- 4 registers (R0–R3), 4 bits each
- 16 × 12-bit instruction memory, 16 × 4-bit data memory
- Hardwired control unit
- Flags: Zero and Carry (no-borrow for SUB)
- Harvard memory model

## Instruction Set
| Opcode | Mnemonic | Operation |
|--------|----------|-----------|
| 0000 | ADD Rd, Rs | Rd ← Rd + Rs |
| 0001 | SUB Rd, Rs | Rd ← Rd − Rs |
| 0010 | AND Rd, Rs | Rd ← Rd & Rs |
| 0011 | OR Rd, Rs | Rd ← Rd \| Rs |
| 0100 | XOR Rd, Rs | Rd ← Rd ^ Rs |
| 0101 | NOT Rd | Rd ← ~Rd |
| 0110 | LDI Rd, imm | Rd ← immediate |
| 0111 | MOV Rd, Rs | Rd ← Rs |
| 1000 | LOAD Rd, addr | Rd ← data_memory[addr] |
| 1001 | STORE Rd, addr | data_memory[addr] ← Rd |
| 1010 | JMP addr | PC ← addr |
| 1011 | JZ addr | if Zero=1, PC ← addr |

## Verification
| Testbench | Level | Checks | Result |
|-----------|-------|--------|--------|
| tb_alu.v | Module | 11 | PASS |
| tb_register_file.v | Module | 11 | PASS |
| tb_control_unit.v | Module | 22 | PASS |
| tb_cpu.v | CPU | 44 | PASS |
| **Total** | | **88** | **88/88 PASS** |

## Author
**Than Nguyen Minh Nguyen** — Roll No: SE204340
