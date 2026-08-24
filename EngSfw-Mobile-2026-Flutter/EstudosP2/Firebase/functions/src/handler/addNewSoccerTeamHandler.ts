import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { saveTeam } from "../repositories/soccerRepository";

export const addNewSoccerTeam = onCall(async (request) => {

  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Login.");
  }

  const name = request.data?.name;
  const foundationYear = request.data?.foundationYear;

  if (!name || name.trim() === "") {
    throw new HttpsError("invalid-argument", "Nome vazio.");
  }

  if (foundationYear === undefined || foundationYear < 1850) {
    throw new HttpsError("invalid-argument", "Ano inválido.");
  }

  const id = await saveTeam({
    name,
    foundationYear
  });

  logger.info("Time salvo", { id });

  return { id, message: "Sucesso" };
});