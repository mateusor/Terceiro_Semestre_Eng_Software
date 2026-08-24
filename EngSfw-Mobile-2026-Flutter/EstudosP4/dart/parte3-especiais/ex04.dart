// Exercício 4 — Erro Médio Quadrático (MSE — Mean Squared Error)
// Muito usado em Machine Learning para medir o desempenho de modelos preditivos.
// Quanto menor o MSE, mais próximas as previsões estão dos valores reais.
//
// Fórmula: MSE = soma((valorReal - valorPrevisto)²) / n
//
// Por que elevar ao quadrado?
// Elevar ao quadrado evita que erros positivos e negativos se anulem.
// Exemplo: prever 12 quando real é 10 (erro +2) e prever 8 quando real é 10 (erro -2).
// Média simples dos erros = 0, mascarando que ambas as previsões foram erradas.
// Com o quadrado, os dois erros contribuem positivamente: (4 + 4) / 2 = 4.

double calcularErroMedioQuadratico(
    List<double> reais, List<double> previstos) {
  if (reais.length != previstos.length) {
    throw ArgumentError('As listas devem ter o mesmo tamanho.');
  }
  if (reais.isEmpty) {
    throw ArgumentError('As listas não podem estar vazias.');
  }

  // TODO: calcular a diferença entre cada par (reais[i] - previstos[i])
  // TODO: elevar cada diferença ao quadrado
  // TODO: retornar a média dos erros quadráticos (soma / n)
  return 0;
}

void main() {
  final reais = [10.0, 20.0, 30.0];
  final previstos = [12.0, 18.0, 33.0];
  print(calcularErroMedioQuadratico(reais, previstos)); // 5.666...

  // Previsão perfeita → MSE = 0
  final perfeito = [5.0, 10.0, 15.0];
  print(calcularErroMedioQuadratico(perfeito, perfeito)); // 0.0

  try {
    calcularErroMedioQuadratico([], []);
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
  }
}
