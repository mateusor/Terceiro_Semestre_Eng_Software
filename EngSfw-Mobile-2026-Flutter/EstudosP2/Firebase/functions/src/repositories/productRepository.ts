import { db } from "../config/firebase";
import { FieldValue } from "firebase-admin/firestore";

export async function saveProduct(data: { name: string; price: number }) {
  const ref = await db.collection("products").add({
    ...data,
    createdAt: FieldValue.serverTimestamp(),
  });

  return ref.id;
}