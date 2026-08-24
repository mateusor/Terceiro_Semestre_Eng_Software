// Exercício 10 — Função contarAprovados
// Crie a função contarAprovados que receba uma lista de mapas (alunos com nome e nota)
// e retorne quantos têm nota >= 6.

int contarAprovados(List<Map<String, dynamic>> alunos) {
  int cont = 0;
  for (int i = 0; i < alunos.length; i++) {
    if (alunos[i]['nota'] >= 6) {
      cont++;
    }
  }
  return cont;
}

void main() {
  final alunos = [
    {'nome': 'Ana', 'nota': 7.5},
    {'nome': 'Pedro', 'nota': 4.0},
    {'nome': 'Maria', 'nota': 6.0},
    {'nome': 'João', 'nota': 3.5},
    {'nome': 'Beatriz', 'nota': 8.0},
  ];

  print(contarAprovados(alunos)); // 3
}
