// Exercício 3 — Similaridade do Cosseno
// Muito usada em IA: sistemas de recomendação, busca semântica, embeddings.
//
// Fórmula: similaridade = produtoEscalar(A, B) / (módulo(A) * módulo(B))
//
// Interpretação:
//   Próximo de  1.0 → vetores muito similares (mesma direção)
//   Próximo de  0.0 → pouca relação (vetores perpendiculares)
//   Valor negativo  → direções opostas
//
// Valores próximos de 1.0 indicam alta similaridade porque o cosseno de 0° = 1.
// Quanto menor o ângulo entre dois vetores, mais próximos eles são em conteúdo.

import 'dart:math';

double calcularSimilaridadeCosseno(List<double> a, List<double> b) {
  if (a.length != b.length) {
    throw ArgumentError('Os vetores devem ter o mesmo tamanho.');
  }

  // TODO: calcular o produto escalar (soma de a[i] * b[i])

  // TODO: calcular o módulo de cada vetor (raiz quadrada da soma dos quadrados)

  // TODO: tratar caso onde módulo é zero (retornar 0.0)

  // TODO: retornar produtoEscalar / (moduloA * moduloB)
  return 0;
}

void main() {
  // Vetores paralelos → similaridade 1.0
  final a1 = [1.0, 2.0, 3.0];
  final b1 = [2.0, 4.0, 6.0];
  print(calcularSimilaridadeCosseno(a1, b1)); // ~1.0

  // Vetores perpendiculares → similaridade 0.0
  final a2 = [1.0, 0.0];
  final b2 = [0.0, 1.0];
  print(calcularSimilaridadeCosseno(a2, b2)); // ~0.0

  // Vetores opostos → similaridade -1.0
  final a3 = [1.0, 0.0];
  final b3 = [-1.0, 0.0];
  print(calcularSimilaridadeCosseno(a3, b3)); // ~-1.0
}
