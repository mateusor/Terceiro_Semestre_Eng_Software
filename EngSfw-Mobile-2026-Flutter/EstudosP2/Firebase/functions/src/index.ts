import { setGlobalOptions } from "firebase-functions";
import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";

setGlobalOptions({ maxInstances: 10 });

export const olaMundo = onRequest((req, res) => {
  logger.info("Executou a function");

  res.send("Olá Mateus, Function funcionando!");
});
