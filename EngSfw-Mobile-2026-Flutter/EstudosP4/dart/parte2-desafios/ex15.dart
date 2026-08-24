// Exercício 15 — Fatorial
// Função que recebe um inteiro n e retorna o seu fatorial.
// Fatorial de 0 = 1. Lançar exceção para valores negativos.

int fatorial(int n) {
  if (n < 0) throw ArgumentError('Fatorial não definido para negativos.');

  int resultado = 1;

  for (int i = 2; i <= n; i++) {
    resultado *= i;
  }
  return resultado;
}

void main() {
  print(fatorial(0)); // 1
  print(fatorial(1)); // 1
  print(fatorial(5)); // 120
  print(fatorial(7)); // 5040

  try {
    fatorial(-1);
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
  }
}
