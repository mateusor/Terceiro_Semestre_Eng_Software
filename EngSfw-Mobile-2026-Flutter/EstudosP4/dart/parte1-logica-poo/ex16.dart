// Exercício 16 — Classe ContaBancaria
// Crie a classe ContaBancaria com titular e saldo.
// Métodos: depositar, sacar (não permite saldo negativo) e exibirSaldo.

class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    if (valor > 0) {
      saldo += valor;
    }
  }

  void sacar(double valor) {
    if (valor > saldo) {
      print('Saldo insuficiente ${saldo}');
    } else {
      saldo -= valor;
    }
  }

  void exibirSaldo() {
    print('Saldo: ${saldo}');
  }
}

void main() {
  final conta = ContaBancaria('Ana', 1000.0);
  conta.exibirSaldo();
  conta.depositar(500.0);
  conta.exibirSaldo();
  conta.sacar(200.0);
  conta.exibirSaldo();
  conta.sacar(2000.0); // deve exibir mensagem de erro
  conta.exibirSaldo();
}
