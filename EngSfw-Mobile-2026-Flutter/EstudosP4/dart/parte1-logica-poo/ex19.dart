// Exercício 19 — Classe Pedido e maior valor
// Crie a classe Pedido com numero, cliente e valorTotal.
// Função que recebe lista de pedidos e retorna o de maior valor.

class Pedido {
  int numero;
  String cliente;
  double valorTotal;

  Pedido(this.numero, this.cliente, this.valorTotal);

  @override
  String toString() =>
      'Pedido #$numero — $cliente — R\$ ${valorTotal.toStringAsFixed(2)}';
}

Pedido? maiorPedido(List<Pedido> pedidos) {
  Pedido maior = pedidos[0];
  for (var pedido in pedidos) {
    if (pedido.valorTotal > maior.valorTotal) {
      maior = pedido;
    }
  }
  return maior;
}

void main() {
  final pedidos = [
    Pedido(1, 'Ana', 150.0),
    Pedido(2, 'Pedro', 320.0),
    Pedido(3, 'Maria', 80.0),
    Pedido(4, 'João', 490.0),
  ];

  print(maiorPedido(pedidos)); // Pedido #4 — João — R$ 490.00
}
