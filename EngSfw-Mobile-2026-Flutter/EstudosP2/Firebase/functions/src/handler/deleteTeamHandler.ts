import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { deleteTeamById } from "../repositories/deleteTeamRepository";
//Implemente deleteTeam que deleta um time por id.

export const deleteTeam = onCall(async (request) => {

  if (!request.auth) {
    throw new HttpsError("unauthenticated", "login obrigatório");
  }

  const id = request.data?.id;

  if(!id || id.trim()===""){
    throw new 
    HttpsError('invalid-argument',"vazio");
  }

  await deleteTeamById(id.trim());

  logger.info("Time deletado", {id});

  return {
    message: "Deletado com sucesso"
  };
});