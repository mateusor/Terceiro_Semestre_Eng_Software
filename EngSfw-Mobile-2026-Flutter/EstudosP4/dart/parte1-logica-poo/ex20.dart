// Exercício 20 — Sistema de gerenciamento de alunos
// Sistema que permite: cadastrar alunos, listar todos e listar aprovados.
// Use classe, lista, função e método.

class Aluno {
  String nome;
  String ra;
  double nota;

  Aluno(this.nome, this.ra, this.nota);

  bool aprovado() => nota >= 6.0;

  @override
  String toString() => 'Nome: $nome, RA: $ra, Nota: $nota';
}

final List<Aluno> alunos = [];

void cadastrarAluno(String nome, String ra, double nota) {
  alunos.add(Aluno(nome, ra, nota));
}

void listarTodos() {
  for (var a in alunos) {
    print(a);
  }
}

void listarAprovados() {
  for (var a in alunos) {
    if (a.aprovado()) {
      print(a);
    }
  }
}

void main() {
  cadastrarAluno('Tiago', '1234', 8.5);
  cadastrarAluno('Pedro', '1235', 4.0);
  cadastrarAluno('Ana', '1236', 7.0);

  print('--- Todos ---');
  listarTodos();

  print('--- Aprovados ---');
  listarAprovados();
}
