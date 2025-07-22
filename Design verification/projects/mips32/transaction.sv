`ifndef TRANSACTION_SV
`define TRANSACTION_SV

typedef struct {
  bit [31:0] instr_mem[0:31];
  bit [31:0] init_reg[0:31];
} mips_txn;

`endif
