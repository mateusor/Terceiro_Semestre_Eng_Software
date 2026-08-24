// Exercício 18 — Classe Contato com busca por nome
// Classe Contato com nome, telefone e email.
// Função buscarContato que procura pelo nome em uma lista.

class Contato {
  String nome;
  String telefone;
  String email;

  Contato(this.nome, this.telefone, this.email);

  @override
  String toString() => '$nome | $telefone | $email';
}

Contato? buscarContato(List<Contato> contatos, String nome) {
  // TODO: implementar (retorne null se não encontrar)
  return null;
}

void main() {
  final contatos = [
    Contato('Ana', '(19) 99999-0001', 'ana@email.com'),
    Contato('Pedro', '(19) 99999-0002', 'pedro@email.com'),
    Contato('Maria', '(19) 99999-0003', 'maria@email.com'),
  ];

  print(buscarContato(contatos, 'Pedro')); // Pedro | (19) 99999-0002 | pedro@email.com
  print(buscarContato(contatos, 'Lucas')); // null
}
