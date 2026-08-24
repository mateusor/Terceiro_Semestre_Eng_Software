import { db } from "../config/firebase";

export async function getTeamById(id: string) {
  const doc = await db.collection("Teams").doc(id).get();

  if (!doc.exists) {
    return null;
  }

  return {
    id: doc.id,
    ...doc.data(),
  };
}

