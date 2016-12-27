open OUnit2
open Calculator
open Operation

let tests = [
  "calculate with add" >:: (fun _ ->
    assert_equal
      (Ok 3.0)
      (calculate [Operand 2.0; Operand 1.0; Operator Add]));

  "calculate with subtract" >:: (fun _ ->
    assert_equal
      (Ok 3.0)
      (calculate [Operand 5.0; Operand 2.0; Operator Subtract]));

  "calculate with multiply" >:: (fun _ ->
    assert_equal
      (Ok 6.0)
      (calculate [Operand 3.0; Operand 2.0; Operator Multiply]));

  "calculate with divide" >:: (fun _ ->
    assert_equal
      (Ok 4.0)
      (calculate [Operand 8.0; Operand 2.0; Operator Divide]));

  "calculate with factorial" >:: (fun _ ->
    assert_equal
      (Ok 120.0)
      (calculate [Operand 5.0; Operator Factorial]));

  "calculate with power" >:: (fun _ ->
    assert_equal
      (Ok 81.0)
      (calculate [Operand 3.0; Operand 4.0; Operator Power]));

  "calculate with too few operands" >:: (fun _ ->
    assert_equal
      (Error TooFewOperands)
      (calculate [Operand 2.0; Operator Add]));

  "calculate with too many operands" >:: (fun _ ->
    assert_equal
      (Error TooManyOperands)
      (calculate [Operand 2.0; Operand 2.0;]));

  "prepare" >:: (fun _ ->
    assert_equal
      [Operand 3.0; Operand 2.0; Operator Add]
      (prepare 2.0 [Parser.Operand 3.0; Parser.Underscore; Parser.Operator Add]));
]
