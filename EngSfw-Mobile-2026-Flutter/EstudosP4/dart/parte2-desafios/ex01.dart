// Exercício 1 — Palíndromo
// Crie um programa que receba uma palavra e informe se ela é um palíndromo.
// Palíndromo = lida igual de frente para trás.

bool ehPalindromo(String palavra) {
  String invertida = '';

  for (int i = palavra.length - 1; i >= 0; i--) {
    invertida += palavra[i];
  }
  return palavra == invertida;
}

void main() {
  print(ehPalindromo('arara')); // true
  print(ehPalindromo('radar')); // true
  print(ehPalindromo('level')); // true
  print(ehPalindromo('flutter')); // false
  print(ehPalindromo('dart')); // false
}
