open OUnit2
open Parser
open Operation

let tests =  [
  "parse operands" >:: (fun _ ->
    assert_equal
      (Ok [Operand 1.0; Operand 1.0; Operand 0.5; Operand 1.0; Operand (-1.0)])
      (Parser.parse "1 1.0 .5 1. -1"));

  "parse operators" >:: (fun _ ->
    assert_equal
      (Ok [ Operator Add; Operator Subtract; Operator Multiply
          ; Operator Divide; Operator Factorial; Operator Power])
      (Parser.parse "+ - * / ! ^"));

  "parse underscore" >:: (fun _ ->
    assert_equal (Ok [Underscore]) (Parser.parse "_"));

  "parse extra whitespace" >:: (fun _ ->
    assert_equal
      (Ok [Operand 1.0; Operand 2.0; Operator Add])
      (Parser.parse "1   2 +"));

  "parse invalid token" >:: (fun _ ->
    assert_equal (Error (UnknownToken "&")) (Parser.parse "1 2 &"));
]
