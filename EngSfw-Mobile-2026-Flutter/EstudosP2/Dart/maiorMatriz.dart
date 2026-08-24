int maiorDaMatriz(List<List<int>> mat) {
  int maior = mat[0][0];

  for (int i = 0; i < mat.length; i++) {
    for (int j = 0; j < mat[i].length; j++) {
      if (mat[i][j] > maior) {
        maior = mat[i][j];
      }
    }
  }

  return maior;
}