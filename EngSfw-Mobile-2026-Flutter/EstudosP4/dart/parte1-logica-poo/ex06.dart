// Exercício 6 — Função somarLista
// Crie uma função chamada somarLista que receba uma lista de inteiros e retorne a soma.

int somarLista(List<int> numeros) {
  int soma = 0;
  for (int i = 0; i < numeros.length; i++) {
    soma += numeros[i];
  }
  return soma;
}

void main() {
  print(somarLista([1, 2, 3, 4, 5])); // 15
  print(somarLista([10, -5, 20])); // 25
  print(somarLista([])); // 0
}
