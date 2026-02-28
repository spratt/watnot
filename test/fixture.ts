// A simple add function
export function add(a: i32, b: i32): i32 {
  // add the two parameters
  return a + b;
}

// Fibonacci sequence
export function fib(n: i32): i32 {
  // base case
  if (n <= 1) return n;
  // recursive case
  return fib(n - 1) + fib(n - 2);
}
