// Exercício 19 — Classe Livro, filtrar publicados após 2020
// Classe Livro com titulo, autor e anoPublicacao.
// Função que retorna apenas os livros publicados depois de 2020 (ano > 2020).

class Livro {
  String titulo;
  String autor;
  int anoPublicacao;

  Livro(this.titulo, this.autor, this.anoPublicacao);

  @override
  String toString() => '"$titulo" — $autor ($anoPublicacao)';
}

List<Livro> livrosRecentes(List<Livro> livros) {
  // TODO: implementar
  return [];
}

void main() {
  final livros = [
    Livro('Clean Code', 'Robert Martin', 2008),
    Livro('Flutter in Action', 'Eric Windmill', 2020),
    Livro('Dart Apprentice', 'Team Ray Fix', 2021),
    Livro('Programming Dart', 'Kathy Walrath', 2023),
    Livro('Design Patterns', 'Gang of Four', 1994),
  ];

  livrosRecentes(livros).forEach(print);
  // "Dart Apprentice" — Team Ray Fix (2021)
  // "Programming Dart" — Kathy Walrath (2023)
}
