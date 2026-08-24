// Exercício 1 — Calcular MMC (Mínimo Múltiplo Comum)
// Regras:
//   - Não aceitar zero como argumento
//   - Funcionar corretamente com negativos
//   - Sempre retornar um inteiro positivo
//
// Dica: MMC(a, b) = |a * b| / MDC(a, b)

int calcularMDC(int a, int b) {
  // TODO: implementar MDC usando o algoritmo de Euclides
  return 0;
}

int calcularMMC(int a, int b) {
  if (a == 0 || b == 0) {
    throw ArgumentError('Os valores não podem ser zero.');
  }
  // TODO: implementar usando calcularMDC
  return 0;
}

void main() {
  print(calcularMMC(2, 3));   // 6
  print(calcularMMC(4, 6));   // 12
  print(calcularMMC(8, 12));  // 24
  print(calcularMMC(-5, 10)); // 10
  print(calcularMMC(7, 7));   // 7

  try {
    calcularMMC(0, 5);
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
  }
}
