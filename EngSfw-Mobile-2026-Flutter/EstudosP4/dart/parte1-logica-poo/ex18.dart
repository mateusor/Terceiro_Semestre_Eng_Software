// Exercício 18 — Listar tarefas pendentes
// Crie uma lista de objetos Tarefa e uma função que exiba apenas as não concluídas.

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

void exibirPendentes(List<Tarefa> tarefas) {
  for (var tarefa in tarefas) {
    if (tarefa.concluida == false) {
      print(tarefa);
    }
  }
}

void main() {
  final tarefas = [
    Tarefa('Estudar Dart', 'Revisar listas e funções'),
    Tarefa('Fazer exercícios', 'Completar a lista do professor'),
    Tarefa('Ler documentação', 'Flutter docs'),
    Tarefa('Assistir aula', 'Revisão Firebase'),
  ];

  tarefas[0].marcarComoConcluida();
  tarefas[2].marcarComoConcluida();

  print('=== Tarefas pendentes ===');
  exibirPendentes(tarefas);
}
