open OUnit2
open Parser
open Calculator

let test_simple_add _ctx =
  assert_equal
    (Result 3.0)
    (Calculator.calculate [Operand 2.0; Operand 1.0; Operator Add])

let test_simple_subtract _ctx =
  assert_equal
    (Result 3.0)
    (Calculator.calculate [Operand 5.0; Operand 2.0; Operator Subtract])

let test_simple_multiply _ctx =
  assert_equal
    (Result 6.0)
    (Calculator.calculate [Operand 3.0; Operand 2.0; Operator Multiply])

let test_simple_divide _ctx =
  assert_equal
    (Result 4.0)
    (Calculator.calculate [Operand 8.0; Operand 2.0; Operator Divide])

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
    [
      "Calculator handles simple addition">::       test_simple_add;
      "Calculator handles simple subtraction">::    test_simple_subtract;
      "Calculator handles simple multiplication">:: test_simple_multiply;
      "Calculator handles simple division">::       test_simple_divide;

      "Calculator returns error if there are too few operands">::
        test_stack_too_few_operands;
      "Calculator returns error if there are too muck operands">::
        test_stack_too_much_operands;
    ]
