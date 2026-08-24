// Exercício 3 — Função ehPar
// Crie uma função chamada ehPar que receba um número inteiro e retorne
// true se for par ou false se for ímpar. Teste com pelo menos 5 valores.

bool ehPar(int numero) {
  if (numero % 2 == 0) {
    return true;
  } else {
    return false;
  }
}

void main() {
  print(ehPar(4));
  print(ehPar(7));
}
