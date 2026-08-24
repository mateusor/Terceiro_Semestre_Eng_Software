// Exercício 11 — Aplicar 10% de desconto
// Receba uma lista de preços e aplique 10% de desconto em todos os valores.
// Exiba a nova lista de preços.

void main() {
  List<double> precos = [100.0, 250.0, 49.90, 320.0, 15.50];
  for (int i = 0; i < precos.length; i++) {
    double precosNovos = precos[i] - precos[i] * 0.1;
    print(precosNovos);
  }
}
