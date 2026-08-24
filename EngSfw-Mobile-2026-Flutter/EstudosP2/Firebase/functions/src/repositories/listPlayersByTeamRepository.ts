import { db } from "../config/firebase";

export async function listAllPlayersByTeamId(teamId : String){

    const snapshot = await db.collection
    ("players")
    .where("teamId", "==", teamId)
    .orderBy("name", "asc").get();

    return snapshot.docs.map((doc)=>({id : doc.id, ...doc.data()}));
}