# Firebase Functions — Configuração do ambiente

## Pré-requisitos

- Node.js 18+
- Firebase CLI: `npm install -g firebase-tools`
- Conta no Firebase com projeto criado

## Configuração inicial

```bash
# Faça login no Firebase
firebase login

# Inicialize o projeto (escolha "Functions" quando perguntado)
firebase init functions

# Instale as dependências
cd functions
npm install
```

## Estrutura esperada do projeto Firebase

```
meu-projeto-firebase/
├── firebase.json
├── .firebaserc
└── functions/
    ├── package.json
    ├── index.js          ← cole as funções aqui (ou importe os arquivos)
    └── src/
        └── index.ts      ← para a versão TypeScript (exercício 11)
```

## Como usar os arquivos desta pasta

Cada arquivo `ex0X_nomeFuncao.js` contém uma função isolada.
Para testar, copie o conteúdo para `functions/index.js` do seu projeto Firebase.

## Rodar localmente com o emulator

```bash
firebase emulators:start
```

Acesse as funções onRequest em:
`http://localhost:5001/<projeto-id>/us-central1/<nomeFuncao>`

Para funções onCall, use o SDK do Flutter ou o cliente Firebase no emulator.

## Diferença entre onRequest e onCall

| onRequest | onCall |
|-----------|--------|
| Função HTTP padrão (REST) | Chamada pelo SDK Firebase |
| Qualquer cliente HTTP pode chamar | Requer SDK Firebase no cliente |
| Acessa req/res diretamente | Recebe `data` e `context` |
| Usa códigos HTTP (200, 400, 500) | Lança `HttpsError` para erros |
| Bom para APIs públicas | Bom para apps autenticados |

## Deploy para produção

```bash
firebase deploy --only functions
```
