// Exercício 8 — Todos positivos?
// Função que retorna true se TODOS os números da lista forem positivos (> 0).

bool todosPositivos(List<int> numeros) {
  // TODO: implementar
  return false;
}

void main() {
  print(todosPositivos([1, 2, 3, 4]));    // true
  print(todosPositivos([1, -2, 3, 4]));   // false
  print(todosPositivos([0, 1, 2]));       // false (0 não é positivo)
  print(todosPositivos([]));              // true (vazia = todos positivos)
}
