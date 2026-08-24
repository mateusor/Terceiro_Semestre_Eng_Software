import { db } from "../config/firebase";


export async function listAllTeamsByName(){

    const snapshot = await db.collection("Teams").orderBy("name").get();

    return snapshot.docs.map((doc)=>
         ({id:doc.id,...doc.data(),}));

}