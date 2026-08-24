// Exercício 2 — Média e situação do aluno
// Receba duas notas, calcule a média aritmética e exiba a situação:
//   Aprovado    → média >= 6
//   Recuperação → média entre 4 e 5.9
//   Reprovado   → média < 4

void main() {
  double nota1 = 7.0;
  double nota2 = 5.0;
  double media;

  media = (nota1 + nota2) / 2;

  if (media >= 6) {
    print('Aprovado, Media: ${media}');
  } else if (media >= 4 && media <= 5.9) {
    print('Recuperação, Media: ${media}');
  } else {
    print('Reprovado, Media: ${media}');
  }
}
