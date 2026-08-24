// Exercício 8 — registrarFeedback (onCall)
// Recebe nome, email e mensagem, valida campos obrigatórios e salva no Firestore
// na coleção "feedbacks".

import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

admin.initializeApp();

// cria variável do firestore
const db = admin.firestore();

export const registrarFeedback = onCall(async (request) => {

  // recebe os dados
  const { nome, email, mensagem } = request.data;

  // validação
  if (!nome || !email || !mensagem) {
    throw new HttpsError(
      "invalid-argument",
      "Todos os campos são obrigatórios."
    );
  }

  // salva no firestore
  await db.collection("feedbacks").add({
    nome,
    email,
    mensagem,
    criadoEm: admin.firestore.FieldValue.serverTimestamp(),
  });

  // retorno
  return {
    sucesso: true,
    mensagem: "Feedback registrado com sucesso."
  };
});