// Exercício 7 — converterTemperatura (onRequest)
// Recebe temperatura em Celsius via query string e retorna em Fahrenheit e Kelvin.
// Exemplo: GET /converterTemperatura?celsius=100
//
// Fórmulas:
//   Fahrenheit = (celsius * 9/5) + 32
//   Kelvin     = celsius + 273.15

import {onRequest} from 'firebase-functions/v2/https';

export const converterTemperatura = onRequest((request, response) =>{
    const celsius = Number(request.query.celsius);
    
    if(!celsius){
        response.status(400).json( {erro: 'informe a temperatura'});
        return;
    }

    const fahrenheit = (celsius * 9/5) + 32;
    const kelvin = celsius + 273.15;

    response.json({fahrenheit, kelvin});
})