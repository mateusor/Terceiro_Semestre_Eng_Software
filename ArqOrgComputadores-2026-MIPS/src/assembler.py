"""
assembler.py
------------
Assembler de duas passagens para o subconjunto de MIPS definido em isa.py.

Passagem 1: varre o arquivo montando a tabela de labels (endereço de cada
            instrução, em múltiplos de 4, como um MIPS real).
Passagem 2: converte cada linha em um objeto Instruction, já resolvendo
            offsets de branch e endereços de jump relativos às labels.
"""

from dataclasses import dataclass, field
from typing import List, Optional
from isa import INSTRUCTIONS, REGISTERS, R_TYPE_SET, I_TYPE_SET, J_TYPE_SET


@dataclass
class Instruction:
    addr: int
    raw: str
    mnemonic: str
    itype: str
    opcode: int
    funct: Optional[int] = None
    rs: Optional[int] = None
    rt: Optional[int] = None
    rd: Optional[int] = None
    shamt: int = 0
    imm: Optional[int] = None      # imediato (I-type) já com sinal
    target: Optional[int] = None   # endereço de instrução (J-type) ou de branch (I-type)
    label_ref: Optional[str] = None

    def machine_word(self) -> int:
        """Codifica a instrução em uma palavra de 32 bits (apenas ilustrativo)."""
        if self.itype == "R":
            rs, rt, rd = self.rs or 0, self.rt or 0, self.rd or 0
            return (self.opcode << 26) | (rs << 21) | (rt << 16) | (rd << 11) | \
                   (self.shamt << 6) | (self.funct or 0)
        if self.itype == "I":
            rs, rt = self.rs or 0, self.rt or 0
            imm16 = self.imm & 0xFFFF if self.imm is not None else 0
            return (self.opcode << 26) | (rs << 21) | (rt << 16) | imm16
        if self.itype == "J":
            addr26 = (self.target or 0) & 0x3FFFFFF
            return (self.opcode << 26) | addr26
        raise ValueError(f"Tipo de instrução desconhecido: {self.itype}")


def _strip_comment(line: str) -> str:
    for marker in ("#", "//"):
        idx = line.find(marker)
        if idx != -1:
            line = line[:idx]
    return line.strip()


def _parse_reg(token: str) -> int:
    token = token.strip()
    if token not in REGISTERS:
        raise ValueError(f"Registrador inválido: '{token}'")
    return REGISTERS[token]


def _parse_int(token: str) -> int:
    token = token.strip()
    return int(token, 0)  # aceita decimal, 0x hex, 0b binário


class AssemblerError(Exception):
    pass


def assemble(source: str) -> List[Instruction]:
    lines = source.splitlines()
    cleaned = []

    # --- Passagem 1: descobre labels e monta lista de linhas de instrução ---
    labels = {}
    addr = 0
    for raw_line in lines:
        line = _strip_comment(raw_line)
        if not line:
            continue

        if ":" in line:
            label, _, rest = line.partition(":")
            label = label.strip()
            labels[label] = addr
            line = rest.strip()
            if not line:
                continue

        cleaned.append((addr, line))
        addr += 4

    # --- Passagem 2: decodifica cada instrução ---
    instructions: List[Instruction] = []
    for addr, line in cleaned:
        tokens = line.replace(",", " ").split()
        mnemonic = tokens[0].lower()
        args = tokens[1:]

        if mnemonic not in INSTRUCTIONS:
            raise AssemblerError(f"Instrução desconhecida: '{mnemonic}' (linha: '{line}')")

        info = INSTRUCTIONS[mnemonic]
        itype = info[0]

        if itype == "R":
            _, opcode, funct = info
            if mnemonic == "jr":
                rs = _parse_reg(args[0])
                instructions.append(Instruction(addr, line, mnemonic, "R", opcode,
                                                  funct=funct, rs=rs, rt=0, rd=0))
            elif mnemonic in ("sll", "srl"):
                rd = _parse_reg(args[0]); rt = _parse_reg(args[1]); shamt = _parse_int(args[2])
                instructions.append(Instruction(addr, line, mnemonic, "R", opcode,
                                                  funct=funct, rs=0, rt=rt, rd=rd, shamt=shamt))
            else:
                rd = _parse_reg(args[0]); rs = _parse_reg(args[1]); rt = _parse_reg(args[2])
                instructions.append(Instruction(addr, line, mnemonic, "R", opcode,
                                                  funct=funct, rs=rs, rt=rt, rd=rd))

        elif itype == "I":
            _, opcode = info
            if mnemonic in ("lw", "sw"):
                rt = _parse_reg(args[0])
                offset_base = args[1]
                offset, _, base = offset_base.partition("(")
                base = base.rstrip(")")
                imm = _parse_int(offset) if offset.strip() else 0
                rs = _parse_reg(base)
                instructions.append(Instruction(addr, line, mnemonic, "I", opcode,
                                                  rs=rs, rt=rt, imm=imm))
            elif mnemonic in ("beq", "bne"):
                rs = _parse_reg(args[0]); rt = _parse_reg(args[1])
                label = args[2]
                instructions.append(Instruction(addr, line, mnemonic, "I", opcode,
                                                  rs=rs, rt=rt, label_ref=label))
            elif mnemonic == "lui":
                rt = _parse_reg(args[0]); imm = _parse_int(args[1])
                instructions.append(Instruction(addr, line, mnemonic, "I", opcode,
                                                  rs=0, rt=rt, imm=imm))
            else:  # addi, addiu, andi, ori, slti
                rt = _parse_reg(args[0]); rs = _parse_reg(args[1]); imm = _parse_int(args[2])
                instructions.append(Instruction(addr, line, mnemonic, "I", opcode,
                                                  rs=rs, rt=rt, imm=imm))

        elif itype == "J":
            _, opcode = info
            label = args[0]
            instructions.append(Instruction(addr, line, mnemonic, "J", opcode,
                                              label_ref=label))
        else:
            raise AssemblerError(f"Tipo inesperado para '{mnemonic}'")

    # --- Resolve labels (branches usam offset relativo, jumps usam endereço absoluto/4) ---
    for instr in instructions:
        if instr.label_ref is None:
            continue
        if instr.label_ref not in labels:
            raise AssemblerError(f"Label não definida: '{instr.label_ref}'")
        target_addr = labels[instr.label_ref]

        if instr.mnemonic in ("beq", "bne"):
            # offset em PALAVRAS, relativo a PC+4 (comportamento real do MIPS)
            instr.imm = (target_addr - (instr.addr + 4)) // 4
        else:  # j, jal
            instr.target = target_addr // 4

    return instructions
