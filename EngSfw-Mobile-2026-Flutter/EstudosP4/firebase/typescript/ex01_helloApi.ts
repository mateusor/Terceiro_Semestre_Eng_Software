// Exercício 1 — helloApi (onRequest)
// Responder uma requisição HTTP retornando JSON com:
//   mensagem: "Olá, Firebase Functions!"
//   timestamp: data e hora da execução em ISO 8601

import { onRequest } from "firebase-functions/v2/https";

export const helloApi = onRequest((request, response) => {
  response.json({
    mensagem: "Olá, Firebase Functions!",
    timestamp: new Date(),
  });
});
