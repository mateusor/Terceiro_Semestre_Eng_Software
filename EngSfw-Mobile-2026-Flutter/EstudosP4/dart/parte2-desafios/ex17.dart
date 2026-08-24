// Exercício 17 — Fila de atendimento
// Simule uma fila: adicionar pessoa, atender a primeira (remove e retorna), exibir fila.

class FilaAtendimento {
  final List<String> _fila = [];

  void adicionar(String pessoa) {
    // TODO: implementar (adiciona no final)
  }

  String? atender() {
    // TODO: implementar (remove e retorna o primeiro; null se fila vazia)
    return null;
  }

  void exibirFila() {
    // TODO: implementar
    print('Fila atual: $_fila');
  }
}

void main() {
  final fila = FilaAtendimento();

  fila.adicionar('Ana');
  fila.adicionar('Pedro');
  fila.adicionar('Maria');
  fila.exibirFila(); // [Ana, Pedro, Maria]

  print('Atendendo: ${fila.atender()}'); // Atendendo: Ana
  fila.exibirFila();                      // [Pedro, Maria]

  print('Atendendo: ${fila.atender()}'); // Atendendo: Pedro
  fila.exibirFila();                      // [Maria]
}
