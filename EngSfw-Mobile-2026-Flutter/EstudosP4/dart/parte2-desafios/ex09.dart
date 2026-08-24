// Exercício 9 — Diferença entre duas listas
// Função que recebe duas listas de mesmo tamanho e retorna a diferença elemento a elemento.
// Deve lançar ArgumentError se os tamanhos forem diferentes.

List<int> diferencaListas(List<int> a, List<int> b) {
  if (a.length != b.length) {
    throw ArgumentError('As listas devem ter o mesmo tamanho.');
  }
  // TODO: implementar (resultado[i] = a[i] - b[i])
  return [];
}

void main() {
  print(diferencaListas([5, 8, 10], [2, 3, 4])); // [3, 5, 6]
  print(diferencaListas([10, 5], [3, 2]));        // [7, 3]

  try {
    diferencaListas([1, 2], [1, 2, 3]);
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
  }
}
