// Exercício 3 — calcularFrete (onRequest)
// Recebe distanciaKm e pesoKg via query string e retorna o valor do frete.
// Exemplo: GET /calcularFrete?distanciaKm=100&pesoKg=5
//
// Sugestão de fórmula simples:
//   frete = (distanciaKm * 0.10) + (pesoKg * 2.50)   (valores livres para criar)

import {onRequest} from 'firebase-functions/v2/https';


export const calcularFrete = onRequest((request, response) => {
    
    const distanciaKm = request.query.distanciaKm;
    const pesoKg = request.query.pesoKg
    
    if(distanciaKm || pesoKg )
})