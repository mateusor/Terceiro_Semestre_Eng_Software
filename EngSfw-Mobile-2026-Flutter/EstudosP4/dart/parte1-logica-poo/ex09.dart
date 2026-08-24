// Exercício 9 — Mapa de aluno
// Crie um Map que represente um aluno com: nome, matrícula, curso e nota final.
// Exiba cada informação em uma linha separada.

void main() {
  Map<String, dynamic> aluno = {
    'nome': 'Tiago',
    'ra': '1234',
    'curso': 'Engenharia',
    'nota': 10.0,
  };

  print('Nome: ${aluno['nome']}');
  print('RA: ${aluno['ra']}');
  print('Curso: ${aluno['curso']}');
  print('Nota: ${aluno['nota']}');
}
