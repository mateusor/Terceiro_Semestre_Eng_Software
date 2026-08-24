// Exercício 16 — Sequência de Fibonacci
// Função que recebe n e retorna lista com os n primeiros números de Fibonacci.
// Sequência: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

List<int> fibonacci(int n) {
  if (n <= 0) return [];
  List<int> fib = [0, 1];
  for (int i = 2; i < n; i++) {
    fib.add(fib[i - 1] + fib[i - 2]);
  }
  return fib;
}

void main() {
  print(fibonacci(1)); // [0]
  print(fibonacci(2)); // [0, 1]
  print(fibonacci(8)); // [0, 1, 1, 2, 3, 5, 8, 13]
  print(fibonacci(10)); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
}
