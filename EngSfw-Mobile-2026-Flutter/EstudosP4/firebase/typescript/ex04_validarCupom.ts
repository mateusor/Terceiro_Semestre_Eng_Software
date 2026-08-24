// Exercício 4 — validarCupom (onCall)
// Recebe um código de cupom e retorna se é válido ou inválido.
// Cupons válidos fixos: TPDM10, FLUTTER15, PUC20

import {onCall, HttpsError} from 'firebase-functions/v2/https';


export const validarCupom = onCall((request) =>{
    
    const cupom = request.data?.cupom;

    if(!cupom) throw new HttpsError('invalid-argument', 'Digite um cupom valido');

    const cuponsValidos = ['TPDM10', 'FLUTTER15', 'PUC20'];
    const valido = cuponsValidos.includes(cupom);

    return{valido};

    
})
