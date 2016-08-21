open OUnit2

let test_factorial_positive _ctx =
  assert_equal (Operation.Result 120.0) (Operation.factorial 5.0)

let test_factorial_partial _ctx =
  assert_equal (Operation.Result 120.0) (Operation.factorial 5.9)

let test_factorial_zero _ctx =
  assert_equal (Operation.Result 1.0) (Operation.factorial 0.0)

let test_factorial_negative _ctx =
  assert_equal Operation.Error (Operation.factorial (-1.0))

let test_add _ctx =
  assert_equal (Operation.Result 6.0) (Operation.add 3.0 3.0)

let test_subtract _ctx =
  assert_equal (Operation.Result 3.0) (Operation.subtract 6.0 3.0)

let test_multiply _ctx =
  assert_equal (Operation.Result 9.0) (Operation.multiply 3.0 3.0)

let test_divide _ctx =
  assert_equal (Operation.Result 3.0) (Operation.divide 9.0 3.0)

let test_power _ctx =
  assert_equal (Operation.Result 81.0) (Operation.power 3.0 4.0)

let suite =
  "Operation">:::
    [ "Factorial positive">:: test_factorial_positive
    ; "Factorial partial">::  test_factorial_partial
    ; "Factorial negative">:: test_factorial_negative
    ; "Factorial zero">::     test_factorial_zero
    ; "Add">::                test_add
    ; "Subtract">::           test_subtract
    ; "Multiply">::           test_multiply
    ; "Divide">::             test_divide
    ; "Power">::              test_power ]
