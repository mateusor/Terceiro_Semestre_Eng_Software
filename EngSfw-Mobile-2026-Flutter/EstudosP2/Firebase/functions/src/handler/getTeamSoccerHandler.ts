import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { getTeamById } from "../repositories/getTeamRepository";
//Implemente getTeam que busca um time por id. Se não existir, lança not-found.

export const getTeam = onCall(async(request)=>{
    if(!request.auth){
        throw new
        HttpsError("unauthenticated","login");
    }

    const id = request.data?.id;
    
    if(!id){
        throw new
        HttpsError("invalid-argument", "Id");
    }

    
    const team = await getTeamById(id);
    if(!team){
        throw new 
        HttpsError("not-found", "Time nao existe");
    }

    logger.info("Id encontrado", {id});

    return {
        data: id
    };
})