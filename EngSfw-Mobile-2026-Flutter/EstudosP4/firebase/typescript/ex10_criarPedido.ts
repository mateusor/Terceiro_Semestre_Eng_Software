// Exercício 10 — criarPedido (onCall)
// Verifica se o usuário está autenticado, calcula o valor total com base
// nos itens recebidos e salva o pedido na coleção "pedidos" no Firestore.
//
// Estrutura esperada de "data":
//   {
//     itens: [
//       { nome: "Produto A", preco: 50.0, quantidade: 2 },
//       { nome: "Produto B", preco: 30.0, quantidade: 1 },
//     ]
//   }

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const criarPedido = onCall(async (request) => {

  // 1. checar autenticação
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Login necessário.")
  }

  // 2. pegar dados
  const { itens } = request.data

  // 3. calcular total
  let total = 0
  for (const item of itens) {
    total = total + item.preco * item.quantidade
  }
  // Produto A: 50 × 2 = 100
  // Produto B: 30 × 1 =  30
  // total =         130

  // 4. salvar no Firestore (CRIAR)
  const ref = await db.collection("pedidos").add({
    itens,
    total,
    uid: request.auth.uid,
    createdAt: FieldValue.serverTimestamp(),
  })

  return { id: ref.id, total }
})