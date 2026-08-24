// Exercício 10 — Carrinho de compras
// Simule um carrinho com produtos (nome e preço). Exiba o valor total da compra.

class Produto {
  String nome;
  double preco;

  Produto(this.nome, this.preco);

  @override
  String toString() => '$nome — R\$ ${preco.toStringAsFixed(2)}';
}

void main() {
  final carrinho = [
    Produto('Notebook', 3500.0),
    Produto('Mouse', 89.90),
    Produto('Teclado', 149.90),
    Produto('Headset', 220.0),
  ];

  // TODO: exiba os produtos do carrinho

  // TODO: calcule e exiba o valor total da compra
}
