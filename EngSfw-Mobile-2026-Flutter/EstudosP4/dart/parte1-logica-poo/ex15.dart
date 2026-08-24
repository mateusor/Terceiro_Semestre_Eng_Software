// Exercício 15 — Classe Produto com valorTotalEmEstoque
// Crie a classe Produto com nome, preco e quantidadeEmEstoque.
// Método valorTotalEmEstoque retorna preco * quantidadeEmEstoque.

class Produto {
  String nome;
  double preco;
  int quantidadeEmEstoque;

  Produto(this.nome, this.preco, this.quantidadeEmEstoque);

  double valorTotalEmEstoque() {
    double somarValorEstoque = preco * quantidadeEmEstoque;

    return somarValorEstoque;
  }

  @override
  String toString() => '$nome — R\$ $preco x $quantidadeEmEstoque unidades';
}

void main() {
  var p1 = Produto('Bola', 20.0, 10);
  var p2 = Produto('Chupeiras', 30.0, 20);

  print(p1);
  print(p2);
  print(p1.valorTotalEmEstoque());
  print(p2.valorTotalEmEstoque());
}
