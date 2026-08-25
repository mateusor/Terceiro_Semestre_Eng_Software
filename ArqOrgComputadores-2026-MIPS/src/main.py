"""
main.py
-------
Ponto de entrada do simulador. Uso:

    python3 src/main.py programs/soma_vetores.asm
    python3 src/main.py programs/loop_fatorial.asm --no-trace
"""

import sys
import argparse
from assembler import assemble, AssemblerError
from datapath import MipsCPU


def main():
    parser = argparse.ArgumentParser(description="Simulador de datapath MIPS single-cycle")
    parser.add_argument("arquivo", help="Caminho do arquivo .asm a ser executado")
    parser.add_argument("--no-trace", action="store_true",
                         help="Não imprime o trace ciclo a ciclo pelo datapath")
    parser.add_argument("--max-cycles", type=int, default=10_000)
    args = parser.parse_args()

    try:
        with open(args.arquivo, encoding="utf-8") as f:
            source = f.read()
    except FileNotFoundError:
        print(f"Arquivo não encontrado: {args.arquivo}")
        sys.exit(1)

    try:
        program = assemble(source)
    except AssemblerError as e:
        print(f"Erro de montagem: {e}")
        sys.exit(1)

    print(f"Programa montado: {len(program)} instruções.\n")
    for instr in program:
        print(f"  0x{instr.addr:08x}: {instr.raw.strip():<28} "
              f"| word=0x{instr.machine_word():08x}")

    cpu = MipsCPU(program, trace=not args.no_trace)
    cpu.run(max_cycles=args.max_cycles)
    cpu.dump_state()


if __name__ == "__main__":
    main()
