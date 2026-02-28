(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func))
  (func $test/fixture/add (type 0) (param $a i32) (param $b i32) (result i32)
    (return
      (i32.add
        (local.get $a)
        (local.get $b))))
  (func $test/fixture/fib (type 1) (param $n i32) (result i32)
    (if  ;; label = @1
      (i32.le_s
        (local.get $n)
        (i32.const 1))
      (then
        (return
          (local.get $n))))
    (return
      (i32.add
        (call $test/fixture/fib
          (i32.sub
            (local.get $n)
            (i32.const 1)))
        (call $test/fixture/fib
          (i32.sub
            (local.get $n)
            (i32.const 2))))))
  (func $~start (type 2)
    (nop))
  (table $0 1 1 funcref)
  (memory (;0;) 0)
  (export "add" (func $test/fixture/add))
  (export "fib" (func $test/fixture/fib))
  (export "memory" (memory 0))
  (export "_start" (func $~start))
  (elem $0 (i32.const 1) func))
