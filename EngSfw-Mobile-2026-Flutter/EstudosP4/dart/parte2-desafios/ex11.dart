// Exercício 11 — Filtrar produtos acima de R$ 100
// Função que recebe lista de produtos (mapas) e retorna apenas os com preço > 100.

List<Map<String, dynamic>> filtrarProdutosCaros(
    List<Map<String, dynamic>> produtos) {
  // TODO: implementar
  return [];
}

void main() {
  final produtos = [
    {'nome': 'Caneta', 'preco': 5.0},
    {'nome': 'Notebook', 'preco': 3500.0},
    {'nome': 'Mochila', 'preco': 120.0},
    {'nome': 'Borracha', 'preco': 2.0},
    {'nome': 'Fone', 'preco': 250.0},
  ];

  final caros = filtrarProdutosCaros(produtos);
  for (final p in caros) {
    print('${p['nome']} — R\$ ${p['preco']}');
  }
  // Notebook — R$ 3500.0
  // Mochila  — R$ 120.0
  // Fone     — R$ 250.0
}
