// Exercício 3 — Filtrar números pares
// Função que recebe lista de inteiros e retorna nova lista com apenas os pares.

List<int> filtrarPares(List<int> numeros) {
  List<int> pares = [];

  for (var numero in numeros) {
    if (numero % 2 == 0) {
      pares.add(numero);
    }
  }
  return pares;
}

void main() {
  print(filtrarPares([1, 2, 3, 4, 5, 6, 7, 8])); // [2, 4, 6, 8]
  print(filtrarPares([1, 3, 5, 7])); // []
  print(filtrarPares([2, 4, 6])); // [2, 4, 6]
}
