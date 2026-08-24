import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { listAllMoviesByYear } from "../repositories/listMoviesRepository";


//Implemente listMovies que lista todos os filmes ordenados
//por year crescente.

export const listMove = onCall(async(request)=>{
    if(!request.auth){
        throw new
        HttpsError("unauthenticated", "login");
    }
    
    const movie = await listAllMoviesByYear();

    logger.info("Sucess", {movie});

    return {data : movie};
})