Problema: 3 jesuítas e 3 canibais precisam cruzar um rio em barco com capacidade 2.
Regra: em nenhuma margem os canibais podem ser maioria em relação aos jesuítas (se houver jesuítas).

bool estadoValido(int jEsq, int cEsq) {
  
  if (jEsq > 0 && cEsq > jEsq) return false;
  
  int jDir = 3 - jEsq;
  int cDir = 3 - cEsq;
  if (jDir > 0 && cDir > jDir) return false;
  return true;}