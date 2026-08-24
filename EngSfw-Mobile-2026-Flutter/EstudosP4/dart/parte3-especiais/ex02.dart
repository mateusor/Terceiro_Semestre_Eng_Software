// Exercício 2 — Classe Fracao com operação de soma
// A classe deve:
//   - Proibir denominador zero
//   - Usar MMC dos denominadores para somar corretamente
//   - Retornar nova Fracao como resultado
//   - Exibir no formato "numerador/denominador"
//
// Regra de soma de frações:
//   Se denominadores iguais: conserva e soma numeradores
//   Se diferentes: encontrar denominador comum (MMC) antes de somar

int calcularMDC(int a, int b) {
  a = a.abs();
  b = b.abs();
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}

int calcularMMC(int a, int b) {
  return (a.abs() * b.abs()) ~/ calcularMDC(a, b);
}

class Fracao {
  final int numerador;
  final int denominador;

  Fracao(this.numerador, this.denominador) {
    if (denominador == 0) {
      throw ArgumentError('O denominador não pode ser zero.');
    }
  }

  Fracao somar(Fracao outra) {
    // TODO: implementar usando calcularMMC dos denominadores
    return Fracao(0, 1);
  }

  @override
  String toString() => '$numerador/$denominador';
}

void main() {
  final f1 = Fracao(1, 2);
  final f2 = Fracao(1, 3);
  print(f1.somar(f2)); // 5/6

  final f3 = Fracao(1, 4);
  final f4 = Fracao(1, 4);
  print(f3.somar(f4)); // 2/4 (ou 1/2 se implementar simplificação)

  try {
    Fracao(1, 0);
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
  }
}
