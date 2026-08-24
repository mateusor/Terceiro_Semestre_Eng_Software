import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { listAllTeamsByName } from "../repositories/listTeamsRepository";

export const listTeams = onCall(async (request) => {

  // 🔐 autenticação
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Login");
  }

  // 📥 chamada do repository (SEM parâmetro)
  const teams = await listAllTeamsByName();

  logger.info("Lista buscada");

  return {
    teams,
    message: "success"
  };
});