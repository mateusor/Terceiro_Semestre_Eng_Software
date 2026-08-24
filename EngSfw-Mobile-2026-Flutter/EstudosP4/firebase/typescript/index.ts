// Exercício 11 — Todas as Firebase Functions em TypeScript
//
// Diferença prática entre onRequest e onCall:
//   onRequest → função HTTP padrão (REST). Qualquer cliente HTTP pode chamar.
//               Você controla req/res diretamente. Use para APIs públicas.
//   onCall    → chamada pelo SDK Firebase. O SDK cuida da autenticação e
//               serialização. Lança HttpsError para erros. Use para apps
//               Flutter/Android/iOS autenticados.

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

// ─── Tipos auxiliares ────────────────────────────────────────────────────────

interface SomarNumerosData {
  numero1: number;
  numero2: number;
}

interface ValidarCupomData {
  cupom: string;
}

interface CalcMediaData {
  notas: number[];
}

interface FeedbackData {
  nome: string;
  email: string;
  mensagem: string;
}

interface ItemPedido {
  nome: string;
  preco: number;
  quantidade: number;
}

interface CriarPedidoData {
  itens: ItemPedido[];
}

// ─── Ex 1: helloApi (onRequest) ──────────────────────────────────────────────

export const helloApi = functions.https.onRequest((req, res) => {
  // TODO: implementar
  res.status(200).json({
    mensagem: 'Olá, Firebase Functions!',
    timestamp: new Date().toISOString(),
  });
});

// ─── Ex 2: somarNumeros (onCall) ─────────────────────────────────────────────

export const somarNumeros = functions.https.onCall(
  (data: SomarNumerosData, context) => {
    const { numero1, numero2 } = data;

    if (numero1 === undefined || numero2 === undefined) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Os campos numero1 e numero2 são obrigatórios.'
      );
    }

    // TODO: retornar a soma
    return { resultado: 0 }; // TODO: numero1 + numero2
  }
);

// ─── Ex 3: calcularFrete (onRequest) ─────────────────────────────────────────

export const calcularFrete = functions.https.onRequest((req, res) => {
  const distanciaKm = parseFloat(req.query.distanciaKm as string);
  const pesoKg = parseFloat(req.query.pesoKg as string);

  if (isNaN(distanciaKm) || isNaN(pesoKg)) {
    res.status(400).json({ erro: 'Parâmetros distanciaKm e pesoKg são obrigatórios.' });
    return;
  }

  // TODO: calcular o frete
  const valorFrete = 0; // TODO

  res.status(200).json({ distanciaKm, pesoKg, valorFrete });
});

// ─── Ex 4: validarCupom (onCall) ─────────────────────────────────────────────

const CUPONS_VALIDOS = ['TPDM10', 'FLUTTER15', 'PUC20'];

export const validarCupom = functions.https.onCall(
  (data: ValidarCupomData, context) => {
    const { cupom } = data;

    if (!cupom) {
      throw new functions.https.HttpsError('invalid-argument', 'O campo cupom é obrigatório.');
    }

    // TODO: verificar se o cupom é válido
    const valido = false; // TODO: CUPONS_VALIDOS.includes(cupom.toUpperCase())

    return {
      cupom,
      valido,
      mensagem: valido ? 'Cupom válido!' : 'Cupom inválido.',
    };
  }
);

// ─── Ex 5: statusServidor (onRequest) ────────────────────────────────────────

export const statusServidor = functions.https.onRequest((req, res) => {
  // TODO: implementar
  res.status(200).json({
    status: 'ativo',
    metodo: req.method,
    horario: new Date().toISOString(),
  });
});

// ─── Ex 6: calcularMediaAluno (onCall) ───────────────────────────────────────

export const calcularMediaAluno = functions.https.onCall(
  (data: CalcMediaData, context) => {
    const { notas } = data;

    if (!notas || !Array.isArray(notas) || notas.length === 0) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'O campo notas deve ser uma lista não vazia.'
      );
    }

    // TODO: calcular a média
    const media = 0; // TODO

    // TODO: determinar a situação
    let situacao = ''; // TODO

    return { media, situacao };
  }
);

// ─── Ex 7: converterTemperatura (onRequest) ──────────────────────────────────

export const converterTemperatura = functions.https.onRequest((req, res) => {
  const celsius = parseFloat(req.query.celsius as string);

  if (isNaN(celsius)) {
    res.status(400).json({ erro: 'O parâmetro celsius é obrigatório.' });
    return;
  }

  // TODO: calcular Fahrenheit e Kelvin
  const fahrenheit = 0; // TODO: (celsius * 9) / 5 + 32
  const kelvin = 0;     // TODO: celsius + 273.15

  res.status(200).json({ celsius, fahrenheit, kelvin });
});

// ─── Ex 8: registrarFeedback (onCall) ────────────────────────────────────────

export const registrarFeedback = functions.https.onCall(
  async (data: FeedbackData, context) => {
    const { nome, email, mensagem } = data;

    if (!nome || !email || !mensagem) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Os campos nome, email e mensagem são obrigatórios.'
      );
    }

    await db.collection('feedbacks').add({
      nome,
      email,
      mensagem,
      criadoEm: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { sucesso: true };
  }
);

// ─── Ex 9: listarProdutosPublicos (onRequest) ────────────────────────────────

export const listarProdutosPublicos = functions.https.onRequest(
  async (req, res) => {
    try {
      const snapshot = await db
        .collection('produtos')
        .where('ativo', '==', true)
        .get();

      const produtos = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));

      res.status(200).json({ produtos });
    } catch (error: any) {
      res.status(500).json({ erro: 'Erro ao consultar produtos.', detalhe: error.message });
    }
  }
);

// ─── Ex 10: criarPedido (onCall) ─────────────────────────────────────────────

export const criarPedido = functions.https.onCall(
  async (data: CriarPedidoData, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'É necessário estar autenticado para criar um pedido.'
      );
    }

    const { itens } = data;

    if (!itens || !Array.isArray(itens) || itens.length === 0) {
      throw new functions.https.HttpsError('invalid-argument', 'O campo itens é obrigatório.');
    }

    // TODO: calcular o valorTotal somando preco * quantidade de cada item
    const valorTotal = 0; // TODO: itens.reduce(...)

    const pedidoRef = await db.collection('pedidos').add({
      uid: context.auth.uid,
      itens,
      valorTotal,
      status: 'pendente',
      criadoEm: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { sucesso: true, pedidoId: pedidoRef.id, valorTotal };
  }
);
