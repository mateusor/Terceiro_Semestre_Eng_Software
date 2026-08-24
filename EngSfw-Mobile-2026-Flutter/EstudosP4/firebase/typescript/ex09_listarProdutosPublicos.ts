// Exercício 9 — listarProdutosPublicos (onRequest)
// Consulta a coleção "produtos" no Firestore e retorna apenas
// os documentos onde o campo "ativo" é igual a true.

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializedApp();

const db = admin.firestore();

export const listarProdutosPublicos = onRequest(
  async (request, response) => {
    try {
      const snap = await db.collection("produtos")
        .where("ativo", "==", true)
        .get()

      const lista = snap.docs.map((d) => ({ id: d.id, ...d.data() }))

      response.status(200).json({ lista })
    } catch (e) {
      response.status(500).send("erro interno")
    }
  