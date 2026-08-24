// Exercício 5 — Filtrar números positivos
// Percorra uma lista de números inteiros e exiba apenas os números positivos.

void main() {
  List<int> numeros = [-3, 5, -1, 8, 0, 2, -7, 4];

  for (int i = 0; i < numeros.length; i++) {
    if (numeros[i] > 0) {
      print(numeros[i]);
    }
  }
}
