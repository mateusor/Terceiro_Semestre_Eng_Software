import { db } from "../config/firebase";
import { FieldValue } from "firebase-admin/firestore";

export async function saveTeam(data: object) {
  const ref = await db.collection("SoccerTeams").add({
    ...data,
    createdAt: FieldValue.serverTimestamp(),
  });

  return ref.id;
}