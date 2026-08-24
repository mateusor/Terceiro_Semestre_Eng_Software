// Exercício 12 — Função buscarNome
// Crie a função buscarNome que receba uma lista de nomes e um nome buscado.
// Retorne true se o nome existir na lista, false caso contrário.

bool buscarNome(List<String> nomes, String nomeBuscado) {
  for (var nome in nomes) {
    if (nome == nomeBuscado) {
      return true;
    }
  }
  return false;
}

void main() {
  final nomes = ['Ana', 'Pedro', 'Maria', 'João', 'Beatriz'];

  print(buscarNome(nomes, 'Maria')); // true
  print(buscarNome(nomes, 'Lucas')); // false
  print(buscarNome(nomes, 'Beatriz')); // true
}
