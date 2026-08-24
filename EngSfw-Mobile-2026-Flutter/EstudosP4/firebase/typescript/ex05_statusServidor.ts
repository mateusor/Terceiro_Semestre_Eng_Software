// Exercício 5 — statusServidor (onRequest)
// Retorna JSON com:
//   status: "ativo"
//   metodo: método HTTP da requisição (GET, POST, etc.)
//   horario: data/hora da chamada

import {onRequest} from 'firebase-functions/v2/https';

export const statusServidor = onRequest((request, response) => {
    response.json({
        status: 'ativo',
        metodo: request.method,
        horario: new Date().toISOString(),
    });
});
