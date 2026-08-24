# Super lista de exercícios finais — Prova 4

**Autor:** Mateus Dias  
**Instituição:** Pontifícia Universidade Católica de Campinas (PUC-Campinas)  
**Centro:** Escola Politécnica  
**Curso:** Engenharia de Software  
**Disciplina:** Tecnologia e Programação para Dispositivos Móveis (TPDM)  
**Código:** 21813 | **Professor:** Prof. Me. Mateus Dias | **Semestre:** 2026

---

## Estrutura de pastas

```
estudos-tpdm/
├── EXERCICIOS.md               ← você está aqui
├── dart/
│   ├── parte1-logica-poo/     ← ex01.dart a ex20.dart
│   ├── parte2-desafios/       ← ex01.dart a ex20.dart
│   └── parte3-especiais/      ← ex01.dart a ex04.dart
└── firebase/
    ├── javascript/            ← ex01.js a ex10.js
    ├── typescript/            ← index.ts (exercício 11)
    └── README.md
```

---

## Progresso geral

### Parte 1 — Lógica e POO com Dart

- [ ] `parte1-logica-poo/ex01.dart` — Variáveis e formatação de dados
- [ ] `parte1-logica-poo/ex02.dart` — Média e situação do aluno
- [ ] `parte1-logica-poo/ex03.dart` — Função `ehPar`
- [ ] `parte1-logica-poo/ex04.dart` — Função `maiorNumero`
- [ ] `parte1-logica-poo/ex05.dart` — Filtrar números positivos de lista
- [ ] `parte1-logica-poo/ex06.dart` — Função `somarLista`
- [ ] `parte1-logica-poo/ex07.dart` — Função `calcularMedia`
- [ ] `parte1-logica-poo/ex08.dart` — Nomes com mais de 5 letras
- [ ] `parte1-logica-poo/ex09.dart` — Mapa de aluno
- [ ] `parte1-logica-poo/ex10.dart` — Função `contarAprovados`
- [ ] `parte1-logica-poo/ex11.dart` — Aplicar 10% de desconto em lista
- [ ] `parte1-logica-poo/ex12.dart` — Função `buscarNome`
- [ ] `parte1-logica-poo/ex13.dart` — Classe `Aluno`
- [ ] `parte1-logica-poo/ex14.dart` — Método `estaAprovado` na classe `Aluno`
- [ ] `parte1-logica-poo/ex15.dart` — Classe `Produto` com `valorTotalEmEstoque`
- [ ] `parte1-logica-poo/ex16.dart` — Classe `ContaBancaria`
- [ ] `parte1-logica-poo/ex17.dart` — Classe `Tarefa`
- [ ] `parte1-logica-poo/ex18.dart` — Listar tarefas pendentes
- [ ] `parte1-logica-poo/ex19.dart` — Classe `Pedido` e maior valor
- [ ] `parte1-logica-poo/ex20.dart` — Sistema de gerenciamento de alunos

### Parte 2 — Pequenos desafios em Dart

- [ ] `parte2-desafios/ex01.dart` — Palíndromo
- [ ] `parte2-desafios/ex02.dart` — Contar vogais
- [ ] `parte2-desafios/ex03.dart` — Filtrar pares
- [ ] `parte2-desafios/ex04.dart` — Segundo maior número
- [ ] `parte2-desafios/ex05.dart` — Ordenar nomes alfabeticamente
- [ ] `parte2-desafios/ex06.dart` — Maior palavra da lista
- [ ] `parte2-desafios/ex07.dart` — Contar ocorrências de palavras
- [ ] `parte2-desafios/ex08.dart` — Todos os números são positivos?
- [ ] `parte2-desafios/ex09.dart` — Diferença entre duas listas
- [ ] `parte2-desafios/ex10.dart` — Carrinho de compras
- [ ] `parte2-desafios/ex11.dart` — Filtrar produtos acima de R$ 100
- [ ] `parte2-desafios/ex12.dart` — Remover notas inválidas
- [ ] `parte2-desafios/ex13.dart` — Remover duplicatas de lista
- [ ] `parte2-desafios/ex14.dart` — Analisar data dd/mm/aaaa
- [ ] `parte2-desafios/ex15.dart` — Fatorial
- [ ] `parte2-desafios/ex16.dart` — Sequência de Fibonacci
- [ ] `parte2-desafios/ex17.dart` — Fila de atendimento
- [ ] `parte2-desafios/ex18.dart` — Classe `Contato` com busca por nome
- [ ] `parte2-desafios/ex19.dart` — Classe `Livro`, filtrar após 2020
- [ ] `parte2-desafios/ex20.dart` — Agenda simples completa

### Parte 3 — Desafios especiais com Dart

- [ ] `parte3-especiais/ex01.dart` — Função `calcularMMC`
- [ ] `parte3-especiais/ex02.dart` — Classe `Fracao` com soma
- [ ] `parte3-especiais/ex03.dart` — Similaridade do Cosseno
- [ ] `parte3-especiais/ex04.dart` — Erro Médio Quadrático (MSE)

### Parte 4 — Firebase Functions e Firestore

- [ ] `firebase/javascript/ex01_helloApi.js` — `helloApi` onRequest
- [ ] `firebase/javascript/ex02_somarNumeros.js` — `somarNumeros` onCall
- [ ] `firebase/javascript/ex03_calcularFrete.js` — `calcularFrete` onRequest
- [ ] `firebase/javascript/ex04_validarCupom.js` — `validarCupom` onCall
- [ ] `firebase/javascript/ex05_statusServidor.js` — `statusServidor` onRequest
- [ ] `firebase/javascript/ex06_calcularMediaAluno.js` — `calcularMediaAluno` onCall
- [ ] `firebase/javascript/ex07_converterTemperatura.js` — `converterTemperatura` onRequest
- [ ] `firebase/javascript/ex08_registrarFeedback.js` — `registrarFeedback` onCall
- [ ] `firebase/javascript/ex09_listarProdutosPublicos.js` — `listarProdutosPublicos` onRequest
- [ ] `firebase/javascript/ex10_criarPedido.js` — `criarPedido` onCall
- [ ] `firebase/typescript/index.ts` — Todos os exercícios acima em TypeScript

---

## Enunciados completos

### Parte 1 — Lógica e orientação a objetos com Dart

**1.** Crie um programa em Dart que declare três variáveis: o nome de um aluno, sua idade e sua nota final. Em seguida, exiba uma mensagem formatada apresentando esses dados.

**2.** Escreva um programa que receba duas notas de um aluno, calcule a média aritmética e exiba se o aluno foi aprovado, em recuperação ou reprovado. Considere aprovado quem tiver média maior ou igual a 6, recuperação entre 4 e 5.9, e reprovado abaixo de 4.

**3.** Crie uma função chamada `ehPar` que receba um número inteiro e retorne `true` caso ele seja par ou `false` caso seja ímpar. Teste a função com pelo menos cinco valores diferentes.

**4.** Escreva uma função chamada `maiorNumero` que receba três números inteiros e retorne o maior deles.

**5.** Crie um programa que percorra uma lista de números inteiros e exiba apenas os números positivos.

**6.** Crie uma função chamada `somarLista` que receba uma lista de números inteiros e retorne a soma de todos os elementos.

**7.** Crie uma função chamada `calcularMedia` que receba uma lista de números decimais e retorne a média dos valores. Caso a lista esteja vazia, a função deve retornar `0`.

**8.** Escreva um programa que receba uma lista de nomes e exiba somente os nomes que tenham mais de cinco letras.

**9.** Crie um mapa (`Map`) que represente um aluno, contendo nome, matrícula, curso e nota final. Depois, exiba cada informação em uma linha.

**10.** Crie uma função chamada `contarAprovados` que receba uma lista de mapas representando alunos. Cada aluno deve ter nome e nota. A função deve retornar quantos alunos possuem nota maior ou igual a 6.

**11.** Escreva um programa que receba uma lista de preços e aplique 10% de desconto em todos os valores. Ao final, exiba a nova lista de preços.

**12.** Crie uma função chamada `buscarNome` que receba uma lista de nomes e um nome buscado. A função deve retornar `true` caso o nome exista na lista e `false` caso contrário.

**13.** Crie uma classe chamada `Aluno` com os atributos `nome`, `matricula` e `notaFinal`. Depois, crie dois objetos dessa classe e exiba seus dados.

**14.** Na classe `Aluno`, crie um método chamado `estaAprovado` que retorne `true` caso a `notaFinal` seja maior ou igual a 6, e `false` caso contrário.

**15.** Crie uma classe chamada `Produto` com os atributos `nome`, `preco` e `quantidadeEmEstoque`. Adicione um método chamado `valorTotalEmEstoque`, que retorne o valor total daquele produto no estoque.

**16.** Crie uma classe chamada `ContaBancaria` com os atributos `titular` e `saldo`. Adicione os métodos `depositar`, `sacar` e `exibirSaldo`. O método `sacar` não deve permitir saque maior que o saldo disponível.

**17.** Crie uma classe chamada `Tarefa` com os atributos `titulo`, `descricao` e `concluida`. Adicione um método chamado `marcarComoConcluida`, que altere o valor de `concluida` para `true`.

**18.** Crie uma lista de objetos da classe `Tarefa` e escreva uma função que exiba apenas as tarefas ainda não concluídas.

**19.** Crie uma classe chamada `Pedido` com os atributos `numero`, `cliente` e `valorTotal`. Depois, crie uma função que receba uma lista de pedidos e retorne o pedido de maior valor.

**20.** Crie um pequeno sistema em Dart para gerenciar uma lista de alunos. O sistema deve permitir cadastrar alunos, listar todos os alunos e listar apenas os alunos aprovados. Use classe, lista, função e método no mesmo exercício.

---

### Parte 2 — Pequenos desafios em Dart

**1.** Crie um programa que receba uma palavra e informe se ela é um palíndromo. Uma palavra é palíndromo quando pode ser lida da mesma forma da esquerda para a direita e da direita para a esquerda.

**2.** Escreva uma função que receba uma frase e retorne a quantidade de vogais existentes nela.

**3.** Crie uma função que receba uma lista de números inteiros e retorne uma nova lista contendo apenas os números pares.

**4.** Crie uma função que receba uma lista de números inteiros e retorne o segundo maior número da lista.

**5.** Escreva um programa que receba uma lista de nomes e retorne uma nova lista ordenada em ordem alfabética.

**6.** Crie uma função que receba uma lista de palavras e retorne a maior palavra encontrada.

**7.** Escreva um programa que conte quantas vezes cada palavra aparece em uma lista de palavras. Use um `Map<String, int>` para armazenar o resultado.

**8.** Crie uma função que receba uma lista de números e retorne `true` caso todos os números sejam positivos.

**9.** Crie uma função que receba duas listas de números (mesma quantidade) e retorne uma lista que represente a diferença entre os números. Se as listas passadas não tiverem a mesma quantidade de números, lançar uma exceção `ArgumentError`.

**10.** Escreva um programa que simule um carrinho de compras. Cada produto deve ter nome e preço. Ao final, exiba o valor total da compra.

**11.** Crie uma função que receba uma lista de produtos representados por mapas e retorne apenas os produtos com preço maior que R$ 100,00.

**12.** Escreva um programa que receba uma lista de notas e remova todas as notas inválidas. Considere inválidas as notas menores que 0 ou maiores que 10.

**13.** Crie uma função que receba uma lista de números inteiros e retorne uma nova lista sem valores repetidos.

**14.** Escreva um programa que receba uma data no formato `dd/mm/aaaa` e exiba separadamente o dia, o mês e o ano.

**15.** Crie uma função que receba um número inteiro e retorne o seu fatorial.

**16.** Crie uma função que receba um número inteiro `n` e retorne uma lista com os `n` primeiros números da sequência de Fibonacci.

**17.** Escreva um programa que simule uma fila de atendimento. O programa deve permitir adicionar pessoas à fila, atender a primeira pessoa e exibir a fila atual.

**18.** Crie uma classe chamada `Contato` com nome, telefone e email. Depois, crie uma função que busque um contato pelo nome em uma lista de contatos.

**19.** Crie uma classe chamada `Livro` com título, autor e ano de publicação. Depois, escreva uma função que receba uma lista de livros e retorne apenas os livros publicados depois de 2020.

**20.** Implemente uma agenda simples em Dart usando classes, listas e funções. A agenda deve permitir cadastrar contatos, listar contatos, buscar por nome e remover um contato. Sem banco de dados, tudo em memória.

---

### Parte 3 — Desafios especiais com Dart

**1.** Crie uma função chamada `calcularMMC` que receba dois números inteiros e retorne o menor múltiplo comum entre eles. A função deve: não aceitar zero, funcionar com negativos, e sempre retornar um inteiro positivo.

```
calcularMMC(2, 3)   → 6
calcularMMC(4, 6)   → 12
calcularMMC(8, 12)  → 24
calcularMMC(-5, 10) → 10
```

**2.** Crie uma classe chamada `Fracao` com `numerador` e `denominador`. Deve ter: construtor que proíbe denominador zero, método `somar` que usa o MMC dos denominadores, e retorna uma nova `Fracao`.

```dart
final f1 = Fracao(1, 2);
final f2 = Fracao(1, 3);
print(f1.somar(f2)); // 5/6
```

**3.** Crie uma função `calcularSimilaridadeCosseno` que receba dois vetores `List<double>` e retorne a similaridade usando a fórmula do cosseno. Lance exceção se os tamanhos forem diferentes. Trate módulo zero.

```
similaridade = produtoEscalar(A, B) / (módulo(A) * módulo(B))
```

**4.** Crie uma função `calcularErroMedioQuadratico` que receba listas de valores reais e previstos. Lance exceção se tamanhos diferentes ou se listas vazias.

```
MSE = soma((valorReal - valorPrevisto)²) / n

calcularErroMedioQuadratico([10.0, 20.0, 30.0], [12.0, 18.0, 33.0]) → 5.666...
```

---

### Parte 4 — Firebase Functions e Firestore

**1.** `helloApi` (onRequest) — Retornar JSON com mensagem `"Olá, Firebase Functions!"` e `timestamp`.

**2.** `somarNumeros` (onCall) — Receber dois números do Flutter, validar e retornar a soma.

**3.** `calcularFrete` (onRequest) — Receber `distanciaKm` e `pesoKg` via query string, calcular e retornar frete em JSON.

**4.** `validarCupom` (onCall) — Receber código de cupom e validar. Cupons válidos: `TPDM10`, `FLUTTER15`, `PUC20`.

**5.** `statusServidor` (onRequest) — Retornar JSON com status ativo, método HTTP usado e horário da chamada.

**6.** `calcularMediaAluno` (onCall) — Receber lista de notas, validar se não vazia, retornar média e situação (aprovado/recuperação/reprovado).

**7.** `converterTemperatura` (onRequest) — Receber temperatura em Celsius via query string, retornar em Fahrenheit e Kelvin.

**8.** `registrarFeedback` (onCall) — Receber `nome`, `email` e `mensagem`, validar campos obrigatórios, salvar na coleção `feedbacks` no Firestore.

**9.** `listarProdutosPublicos` (onRequest) — Consultar coleção `produtos` no Firestore e retornar apenas os com `ativo: true`.

**10.** `criarPedido` (onCall) — Verificar autenticação, calcular total com base nos itens, salvar na coleção `pedidos` no Firestore.

**11.** Converter todos os exercícios acima para **TypeScript**, organizados no arquivo `typescript/index.ts`. Usar tipagem, `HttpsError` para onCall e códigos HTTP adequados para onRequest.
