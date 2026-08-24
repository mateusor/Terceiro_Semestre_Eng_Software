// Exercício 4 — Função maiorNumero
// Escreva uma função chamada maiorNumero que receba três inteiros e retorne o maior deles.

int maiorNumero(int a, int b, int c) {
  if (a >= b && a >= c) return a;
  if (b >= a && b >= c) return b;
  return c;
}

void main() {
  print(maiorNumero(3, 7, 5)); // 7
  print(maiorNumero(10, 2, 8)); // 10
  print(maiorNumero(1, 1, 1)); // 1
}
