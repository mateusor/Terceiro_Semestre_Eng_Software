"""
datapath.py
-----------
Simulador do datapath MIPS de ciclo único (o clássico do Patterson &
Hennessy). Cada instrução é executada percorrendo, de verdade, os blocos
do datapath na ordem correta:

    PC -> Memória de Instrução -> Unidade de Controle
       -> Banco de Registradores (leitura) -> Sign Extend
       -> ALU (com ALU Control) -> Memória de Dados
       -> Write Back -> Mux de próximo PC (sequencial / branch / jump)

A cada instrução executada, o simulador imprime os sinais de controle
gerados pela Unidade de Controle e o valor que passa por cada bloco,
simulando o que aconteceria fisicamente nos fios do datapath.
"""

from dataclasses import dataclass
from typing import Dict, List
from isa import REG_NAMES, to_signed32, to_unsigned32, sign_extend16
from assembler import Instruction


@dataclass
class ControlSignals:
    reg_dst: int = 0
    branch: int = 0
    bne: int = 0
    mem_read: int = 0
    mem_to_reg: int = 0
    alu_op: str = "add"     # operação final decidida pela ALU Control
    mem_write: int = 0
    alu_src: int = 0
    reg_write: int = 0
    jump: int = 0

    def as_row(self) -> str:
        return (f"RegDst={self.reg_dst} ALUSrc={self.alu_src} MemToReg={self.mem_to_reg} "
                f"RegWrite={self.reg_write} MemRead={self.mem_read} MemWrite={self.mem_write} "
                f"Branch={self.branch} Jump={self.jump} ALUOp={self.alu_op}")


def control_unit(instr: Instruction) -> ControlSignals:
    """
    Unidade de Controle: decodifica opcode/funct e liga os sinais que
    comandam cada mux e cada unidade do datapath.
    """
    c = ControlSignals()
    m = instr.mnemonic

    if instr.itype == "R":
        c.reg_dst = 1
        c.reg_write = 1
        c.alu_op = {
            "add": "add", "addu": "add", "sub": "sub", "subu": "sub",
            "and": "and", "or": "or", "nor": "nor", "slt": "slt",
            "sll": "sll", "srl": "srl", "jr": "passthrough",
        }[m]
        if m == "jr":
            c.reg_write = 0
            c.jump = 1

    elif m == "lw":
        c.alu_src = 1
        c.mem_to_reg = 1
        c.reg_write = 1
        c.mem_read = 1
        c.alu_op = "add"

    elif m == "sw":
        c.alu_src = 1
        c.mem_write = 1
        c.alu_op = "add"

    elif m in ("beq", "bne"):
        c.branch = 1
        c.bne = 1 if m == "bne" else 0
        c.alu_op = "sub"

    elif m in ("addi", "addiu"):
        c.alu_src = 1
        c.reg_write = 1
        c.alu_op = "add"

    elif m == "andi":
        c.alu_src = 1
        c.reg_write = 1
        c.alu_op = "and"

    elif m == "ori":
        c.alu_src = 1
        c.reg_write = 1
        c.alu_op = "or"

    elif m == "slti":
        c.alu_src = 1
        c.reg_write = 1
        c.alu_op = "slt"

    elif m == "lui":
        c.alu_src = 1
        c.reg_write = 1
        c.alu_op = "lui"

    elif m == "j":
        c.jump = 1

    elif m == "jal":
        c.jump = 1
        c.reg_write = 1

    else:
        raise ValueError(f"Sem sinais de controle definidos para '{m}'")

    return c


def alu_execute(op: str, a: int, b: int, shamt: int = 0) -> int:
    """A ALU propriamente dita: recebe dois operandos e devolve o resultado."""
    if op == "add":
        return to_signed32(a + b)
    if op == "sub":
        return to_signed32(a - b)
    if op == "and":
        return to_unsigned32(a) & to_unsigned32(b)
    if op == "or":
        return to_unsigned32(a) | to_unsigned32(b)
    if op == "nor":
        return to_signed32(~(to_unsigned32(a) | to_unsigned32(b)))
    if op == "slt":
        return 1 if a < b else 0
    if op == "sll":
        return to_signed32(to_unsigned32(b) << shamt)
    if op == "srl":
        return to_unsigned32(b) >> shamt
    if op == "lui":
        return to_signed32((b & 0xFFFF) << 16)
    if op == "passthrough":
        return a
    raise ValueError(f"Operação de ALU desconhecida: {op}")


class MipsCPU:
    """
    Representa o estado físico do processador: PC, banco de registradores
    e memória de dados. O método `run` percorre o programa executando
    instrução por instrução através do datapath.
    """

    def __init__(self, program: List[Instruction], trace: bool = True):
        self.program: Dict[int, Instruction] = {i.addr: i for i in program}
        self.pc = 0
        self.regs = [0] * 32
        self.data_mem: Dict[int, int] = {}
        self.trace = trace
        self.cycles = 0

    # ---- utilitários de memória de dados (endereçada por word) ----
    def _mem_read(self, addr: int) -> int:
        return self.data_mem.get(addr, 0)

    def _mem_write(self, addr: int, value: int):
        self.data_mem[addr] = to_signed32(value)

    def _log(self, msg: str):
        if self.trace:
            print(msg)

    def run(self, max_cycles: int = 10_000):
        while self.pc in self.program and self.cycles < max_cycles:
            self.step()
        self._log(f"\n[CPU] Execução encerrada no ciclo {self.cycles} "
                   f"(PC=0x{self.pc:08x} fora do programa ou fim atingido).")

    def step(self):
        instr = self.program[self.pc]
        self.cycles += 1
        self._log(f"\n===== Ciclo {self.cycles} | PC=0x{self.pc:08x} | "
                   f"'{instr.raw.strip()}' =====")

        # ---------------- 1) IF: busca a instrução ----------------
        self._log(f"  [IF ] Memória de Instrução: lê palavra no endereço 0x{self.pc:08x}")
        pc_plus_4 = self.pc + 4

        # ---------------- 2) ID: decodifica + lê registradores ----------------
        control = control_unit(instr)
        self._log(f"  [ID ] Unidade de Controle -> {control.as_row()}")

        rs_val = self.regs[instr.rs] if instr.rs is not None else 0
        rt_val = self.regs[instr.rt] if instr.rt is not None else 0
        self._log(f"  [ID ] Banco de Registradores: read1={REG_NAMES.get(instr.rs,'-')}"
                   f"={rs_val}  read2={REG_NAMES.get(instr.rt,'-')}={rt_val}")

        imm_ext = sign_extend16(instr.imm) if instr.imm is not None else 0
        if instr.imm is not None:
            self._log(f"  [ID ] Sign Extend: imediato 16b -> {imm_ext} (32b)")

        # ---------------- 3) EX: ALU ----------------
        alu_in_b = imm_ext if control.alu_src else rt_val
        alu_result = alu_execute(control.alu_op, rs_val, alu_in_b, instr.shamt)
        zero_flag = 1 if alu_result == 0 else 0
        self._log(f"  [EX ] Mux ALUSrc -> operando B = {alu_in_b} "
                   f"(origem: {'imediato' if control.alu_src else 'registrador'})")
        self._log(f"  [EX ] ALU ({control.alu_op}): {rs_val} op {alu_in_b} "
                   f"=> resultado={alu_result}  Zero={zero_flag}")

        branch_target = pc_plus_4 + (imm_ext * 4)

        # ---------------- 4) MEM: memória de dados ----------------
        mem_result = None
        if control.mem_read:
            mem_result = self._mem_read(alu_result)
            self._log(f"  [MEM] Memória de Dados: lê endereço {alu_result} -> {mem_result}")
        elif control.mem_write:
            self._mem_write(alu_result, rt_val)
            self._log(f"  [MEM] Memória de Dados: escreve {rt_val} no endereço {alu_result}")
        else:
            self._log(f"  [MEM] (não acessada nesta instrução)")

        # ---------------- 5) WB: write back ----------------
        if control.reg_write:
            if instr.mnemonic == "jal":
                write_val = pc_plus_4
                dest = 31  # $ra
            else:
                write_val = mem_result if control.mem_to_reg else alu_result
                dest = instr.rd if control.reg_dst else instr.rt
            if dest != 0:  # $zero nunca é escrito
                self.regs[dest] = to_signed32(write_val)
            self._log(f"  [WB ] Mux MemToReg -> grava {write_val} em "
                      f"{REG_NAMES.get(dest, '$zero')}")
        else:
            self._log(f"  [WB ] (RegWrite=0, nenhum registrador escrito)")

        # ---------------- 6) Próximo PC (mux Branch/Jump) ----------------
        take_branch = control.branch and (
            (not control.bne and zero_flag) or (control.bne and not zero_flag)
        )
        if control.jump:
            if instr.mnemonic == "jr":
                next_pc = rs_val
                self._log(f"  [PC ] Jump register -> PC = {REG_NAMES.get(instr.rs)}"
                          f" = 0x{next_pc:08x}")
            else:
                next_pc = ((pc_plus_4 & 0xF0000000) | ((instr.target or 0) * 4))
                self._log(f"  [PC ] Mux Jump -> PC = 0x{next_pc:08x}")
        elif take_branch:
            next_pc = branch_target
            self._log(f"  [PC ] Mux Branch (tomado) -> PC = 0x{next_pc:08x}")
        else:
            next_pc = pc_plus_4
            self._log(f"  [PC ] Sequencial -> PC = PC + 4 = 0x{next_pc:08x}")

        self.pc = next_pc

    def dump_state(self):
        print("\n----- Estado final dos registradores (não-zero) -----")
        for i in range(32):
            if self.regs[i] != 0:
                print(f"  {REG_NAMES.get(i, f'${i}'):<6} = {self.regs[i]}")
        if self.data_mem:
            print("\n----- Memória de dados usada -----")
            for addr in sorted(self.data_mem):
                print(f"  mem[{addr}] = {self.data_mem[addr]}")
