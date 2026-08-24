// Exercício 14 — Método estaAprovado
// Na classe Aluno, adicione o método estaAprovado que retorna true se notaFinal >= 6.

class Aluno {
  String nome;
  String matricula;
  double notaFinal;

  Aluno(this.nome, this.matricula, this.notaFinal);

  bool estaAprovado() {
    if (notaFinal >= 6) return true;

    return false;
  }

  @override
  String toString() => 'Aluno($nome, $matricula, nota: $notaFinal)';
}

void main() {
  final a1 = Aluno('Ana', '2024001', 7.5);
  final a2 = Aluno('Pedro', '2024002', 4.0);
  final a3 = Aluno('Maria', '2024003', 6.0);

  print('${a1.nome} aprovado? ${a1.estaAprovado()}'); // true
  print('${a2.nome} aprovado? ${a2.estaAprovado()}'); // false
  print('${a3.nome} aprovado? ${a3.estaAprovado()}'); // true
}
