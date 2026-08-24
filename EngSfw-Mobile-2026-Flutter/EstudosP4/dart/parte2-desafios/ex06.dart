// Exercício 6 — Maior palavra da lista
// Função que recebe lista de palavras e retorna a de maior comprimento.

String maiorPalavra(List<String> palavras) {
  String maior = palavras[0];
  for (var palavra in palavras) {
    if (palavra.length > maior.length) {
      maior = palavra;
    }
  }
  return maior;
}

void main() {
  print(maiorPalavra(['Dart', 'Flutter', 'Firebase', 'Kotlin'])); // Firebase
  print(maiorPalavra(['ab', 'abc', 'a', 'abcd'])); // abcd
}
