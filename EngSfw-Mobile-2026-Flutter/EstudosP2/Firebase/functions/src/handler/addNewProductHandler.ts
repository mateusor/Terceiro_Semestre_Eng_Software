import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { saveProduct } from "../repositories/productRepository";

export const addNewProduct = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Login necessário.");
  }

  const name = request.data?.name;
  const price = request.data?.price;

  // ✅ validações corretas
  if (!name || name.trim() === "") {
    throw new HttpsError("invalid-argument", "Nome vazio");
  }

  if (price === undefined || price < 0) {
    throw new HttpsError("invalid-argument", "Preço inválido");
  }

  const id = await saveProduct({ name, price });

  logger.info("Produto salvo", { id });

  return {
    id,
    message: "Success",
  };
});