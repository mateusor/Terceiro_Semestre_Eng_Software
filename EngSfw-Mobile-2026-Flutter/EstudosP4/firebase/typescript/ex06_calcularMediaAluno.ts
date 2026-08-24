// Exercício 6 — calcularMediaAluno (onCall)
// Recebe lista de notas, valida se não está vazia,
// retorna a média e a situação do aluno:
//   Aprovado    → média >= 6
//   Recuperação → média entre 4 e 5.9
//   Reprovado   → média < 4

import {onCall, HttpsError} from 'firebase-functions/v2/https';

export const calcularMediaAluno = onCall((request) => {
  const notas = request.data?.notas;

  if (!notas || notas.length === 0)
    throw new HttpsError("invalid-argument", "Lista vazia.");

  let soma = 0;
for (const nota of notas) {
  soma += nota;
}
const media = soma / notas.length;
  

  let situacao = "";
  if (media >= 6) situacao = "Aprovado";
  else if (media >= 4) situacao = "Recuperação";
  else situacao = "Reprovado";

  return { media, situacao };
});

