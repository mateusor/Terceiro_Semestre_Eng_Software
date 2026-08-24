//Escreva a função que percorre uma matriz e retorna a soma de todos os elementos:

int somarMatriz(List> mat) {
  int soma = 0;

  for (int i =0; i < mat.length; i++){
    for (int j = 0; j < mat[i].length; j ++ ){
        soma += mat[i][j];
    }
  }
  return soma;
}