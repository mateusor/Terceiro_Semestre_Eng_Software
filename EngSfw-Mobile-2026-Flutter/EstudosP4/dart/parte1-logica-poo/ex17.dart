// Exercício 17 — Classe Tarefa
// Crie a classe Tarefa com titulo, descricao e concluida (bool, inicia false).
// Método marcarComoConcluida altera concluida para true.

class Tarefa {
  String titulo;
  String descricao;
  bool concluida;

  Tarefa(this.titulo, this.descricao) : concluida = false;

  void marcarComoConcluida() {
    concluida = true;
  }

  @override
  String toString() => '[${concluida ? 'X' : ' '}] $titulo';
}

void main() {
  final t1 = Tarefa('Estudar Dart', 'Revisar listas e funções');
  final t2 = Tarefa('Fazer exercícios', 'Completar a lista da prova');

  print(t1); // [ ] Estudar Dart
  t1.marcarComoConcluida();
  print(t1); // [X] Estudar Dart
  print(t2); // [ ] Fazer exercícios
}
