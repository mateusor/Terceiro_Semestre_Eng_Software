"""
isa.py
------
Definição do subconjunto do ISA MIPS suportado pelo simulador:
instruções tipo R, I e J, tabela de registradores e utilitários
de conversão entre valores com/sem sinal em 32 bits.
"""

REGISTERS = {
    "$zero": 0, "$0": 0,
    "$at": 1,
    "$v0": 2, "$v1": 3,
    "$a0": 4, "$a1": 5, "$a2": 6, "$a3": 7,
    "$t0": 8, "$t1": 9, "$t2": 10, "$t3": 11,
    "$t4": 12, "$t5": 13, "$t6": 14, "$t7": 15,
    "$s0": 16, "$s1": 17, "$s2": 18, "$s3": 19,
    "$s4": 20, "$s5": 21, "$s6": 22, "$s7": 23,
    "$t8": 24, "$t9": 25,
    "$k0": 26, "$k1": 27,
    "$gp": 28, "$sp": 29, "$fp": 30, "$ra": 31,
}

REG_NAMES = {v: k for k, v in REGISTERS.items() if not k.startswith("$0") and k != "$zero"}
REG_NAMES[0] = "$zero"

# type: R, I, J
# R-type -> opcode sempre 0x00, diferenciado pelo campo funct
# I-type -> diferenciado pelo opcode, formato rs, rt, imediato
# J-type -> diferenciado pelo opcode, formato endereço de 26 bits
INSTRUCTIONS = {
    # R-type: mnemonic -> (opcode, funct)
    "add":  ("R", 0x00, 0x20),
    "addu": ("R", 0x00, 0x21),
    "sub":  ("R", 0x00, 0x22),
    "subu": ("R", 0x00, 0x23),
    "and":  ("R", 0x00, 0x24),
    "or":   ("R", 0x00, 0x25),
    "nor":  ("R", 0x00, 0x27),
    "slt":  ("R", 0x00, 0x2a),
    "sll":  ("R", 0x00, 0x00),
    "srl":  ("R", 0x00, 0x02),
    "jr":   ("R", 0x00, 0x08),

    # I-type: mnemonic -> opcode
    "addi":  ("I", 0x08),
    "addiu": ("I", 0x09),
    "andi":  ("I", 0x0c),
    "ori":   ("I", 0x0d),
    "slti":  ("I", 0x0a),
    "lui":   ("I", 0x0f),
    "lw":    ("I", 0x23),
    "sw":    ("I", 0x2b),
    "beq":   ("I", 0x04),
    "bne":   ("I", 0x05),

    # J-type: mnemonic -> opcode
    "j":   ("J", 0x02),
    "jal": ("J", 0x03),
}

R_TYPE_SET = {m for m, v in INSTRUCTIONS.items() if v[0] == "R"}
I_TYPE_SET = {m for m, v in INSTRUCTIONS.items() if v[0] == "I"}
J_TYPE_SET = {m for m, v in INSTRUCTIONS.items() if v[0] == "J"}


def to_signed32(value: int) -> int:
    value &= 0xFFFFFFFF
    if value & 0x80000000:
        value -= 0x100000000
    return value


def to_unsigned32(value: int) -> int:
    return value & 0xFFFFFFFF


def sign_extend16(value: int) -> int:
    value &= 0xFFFF
    if value & 0x8000:
        value -= 0x10000
    return value
