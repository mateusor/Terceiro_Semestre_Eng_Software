import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { listAllPlayersByTeamId } from "../repositories/listPlayersByTeamRepository";

//Implemente listPlayersByTeam que recebe teamId e lista todos os
//  jogadores da coleção players onde teamId é igual ao recebido,
//  ordenados por name crescente.

export const listPlayersByTeam = onCall(async(request)=>{

    if(!request.auth){
        throw new
        HttpsError("unauthenticated","login");
    }

    const teamId = request.data?.teamId;
    if(!teamId || !teamId.trim() ){
        throw new
        HttpsError("invalid-argument", "Id invalido");
    }

    const player = await listAllPlayersByTeamId(teamId);

    logger.info("Listed", {player});

    return {data : player};
})

