// Exercício 13 — Classe Aluno
// Crie uma classe chamada Aluno com os atributos nome, matricula e notaFinal.
// Crie dois objetos dessa classe e exiba seus dados.

class Aluno {
  String nome;
  String matricula;
  double notaFinal;

  Aluno(this.nome, this.matricula, this.notaFinal);

  @override
  String toString() {
    return 'Nome: $nome\nMatricula: $matricula\nNota: $notaFinal';
  }
}

void main() {
  var a1 = Aluno('Tiago', '1234', 10.0);
  var a2 = Aluno('Magrao', '1124', 3.0);
  print(a1);
  print(a2);
}
