open OUnit2
open Parser
open Calculator

let test_add _ctx =
  assert_equal
    (Result 3.0)
    (Calculator.calculate [Operand 2.0; Operand 1.0; Operator Add])

let test_subtract _ctx =
  assert_equal
    (Result 3.0)
    (Calculator.calculate [Operand 5.0; Operand 2.0; Operator Subtract])

let test_multiply _ctx =
  assert_equal
    (Result 6.0)
    (Calculator.calculate [Operand 3.0; Operand 2.0; Operator Multiply])

let test_divide _ctx =
  assert_equal
    (Result 4.0)
    (Calculator.calculate [Operand 8.0; Operand 2.0; Operator Divide])

let test_factorial _ctx =
  assert_equal
    (Result 120.0)
    (Calculator.calculate [Operand 5.0; Operator Factorial])

let test_stack_too_few_operands _ctx =
  assert_equal
    (Error TooFewOperands)
    (Calculator.calculate [Operand 2.0; Operator Add])

let test_stack_too_much_operands _ctx =
  assert_equal
    (Error TooMuchOperands)
    (Calculator.calculate [Operand 2.0; Operand 2.0; Operand 2.0; Operator Add])

let suite =
  "suite">:::
    [ "addition">::          test_add
    ; "subtraction">::       test_subtract
    ; "multiplication">::    test_multiply
    ; "division">::          test_divide
    ; "factorial">::         test_factorial
    ; "too few operands">::  test_stack_too_few_operands
    ; "too much operands">:: test_stack_too_much_operands ]
