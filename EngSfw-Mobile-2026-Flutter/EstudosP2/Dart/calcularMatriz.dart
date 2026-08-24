void main() {
  List<List<int>> mat = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  int n = mat.length;

  print('Diagonal principal:');
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (i == j) {
        print('mat[$i][$j] = ${mat[i][j]}');
      }
    }
  }

  print('Diagonal secundária:');
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (i + j == n - 1) {
        print('mat[$i][$j] = ${mat[i][j]}');
      }
    }
  }
}