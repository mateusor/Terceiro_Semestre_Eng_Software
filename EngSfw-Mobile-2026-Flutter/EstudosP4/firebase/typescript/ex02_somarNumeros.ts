// Exercício 2 — somarNumeros (onCall)
// Recebe dois números enviados pelo app Flutter, valida e retorna a soma.
// Dados esperados: { numero1: number, numero2: number }

import { onCall, HttpsError } from "firebase-functions/v2/https";


export const somarNumeros = onCall((request)) => {
    
    const a = request.data?.a;
    const b = request.data?.b;

    if(a == null || b == null){
        throw new HttpsError("invalid-argument", "Todos os campos devem ser preenchido");
    }

    const soma = (a+b);

    return soma;
}