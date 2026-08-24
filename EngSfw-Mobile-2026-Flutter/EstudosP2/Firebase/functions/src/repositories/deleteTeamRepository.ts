import { db } from "../config/firebase";

export async function deleteTeamById(id: string) {
  await db.collection("teams").doc(id).delete();
}