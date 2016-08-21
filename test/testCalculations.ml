open OUnit2

let test_factorial_positive _ctx =
  assert_equal (Calculations.Result 120.0) (Calculations.factorial 5.0)

let test_factorial_partial _ctx =
  assert_equal (Calculations.Result 120.0) (Calculations.factorial 5.9)

let test_factorial_zero _ctx =
  assert_equal (Calculations.Result 1.0) (Calculations.factorial 0.0)

let test_factorial_negative _ctx =
  assert_equal Calculations.Error (Calculations.factorial (-1.0))

let test_add _ctx =
  assert_equal (Calculations.Result 6.0) (Calculations.add 3.0 3.0)

let test_subtract _ctx =
  assert_equal (Calculations.Result 3.0) (Calculations.subtract 6.0 3.0)

let test_multiply _ctx =
  assert_equal (Calculations.Result 9.0) (Calculations.multiply 3.0 3.0)

let test_divide _ctx =
  assert_equal (Calculations.Result 3.0) (Calculations.divide 9.0 3.0)

let test_power _ctx =
  assert_equal (Calculations.Result 81.0) (Calculations.power 3.0 4.0)

let suite =
  "Calculations">:::
    [ "Factorial positive">:: test_factorial_positive
    ; "Factorial partial">::  test_factorial_partial
    ; "Factorial negative">:: test_factorial_negative
    ; "Factorial zero">::     test_factorial_zero
    ; "Add">::                test_add
    ; "Subtract">::           test_subtract
    ; "Multiply">::           test_multiply
    ; "Divide">::             test_divide
    ; "Power">::              test_power ]
