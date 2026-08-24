// Exercício 20 — Agenda simples completa
// Agenda com classe Contato. Operações: cadastrar, listar, buscar por nome e remover.
// Tudo em memória (sem banco de dados).

class Contato {
  String nome;
  String telefone;
  String email;

  Contato(this.nome, this.telefone, this.email);

  @override
  String toString() => '$nome | $telefone | $email';
}

class Agenda {
  final List<Contato> _contatos = [];

  void cadastrar(String nome, String telefone, String email) {
    // TODO: implementar
  }

  void listar() {
    if (_contatos.isEmpty) {
      print('Agenda vazia.');
      return;
    }
    // TODO: exibir todos os contatos
  }

  Contato? buscar(String nome) {
    // TODO: implementar (busca case-insensitive é um plus)
    return null;
  }

  void remover(String nome) {
    // TODO: implementar (exibir mensagem se não encontrar)
  }
}

void main() {
  final agenda = Agenda();

  agenda.cadastrar('Ana', '(19) 99999-0001', 'ana@email.com');
  agenda.cadastrar('Pedro', '(19) 99999-0002', 'pedro@email.com');
  agenda.cadastrar('Maria', '(19) 99999-0003', 'maria@email.com');

  print('=== Lista de contatos ===');
  agenda.listar();

  print('\n=== Buscar Pedro ===');
  print(agenda.buscar('Pedro'));

  print('\n=== Remover Ana ===');
  agenda.remover('Ana');

  print('\n=== Lista após remoção ===');
  agenda.listar();

  print('\n=== Buscar Lucas (não existe) ===');
  print(agenda.buscar('Lucas'));
}
