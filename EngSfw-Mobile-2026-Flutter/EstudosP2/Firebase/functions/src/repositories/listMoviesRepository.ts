import { db } from "../config/firebase";

export async function listAllMoviesByYear(){
    const snapshot = await db.collection("movie").orderBy("year", "asc").get();

    return (
        snapshot.docs.map((doc)=> ({id:doc.id, ...doc.data()}))
    )
}