open OUnit2
open Parser
open Operation

let test_parse_whitespace _ctx =
  assert_equal
    (Ok [Operand 1.0; Operand 2.0; Operator Add])
    (Parser.parse "1   2 +")

let test_parse_operands _ctx =
  assert_equal
    (Ok [Operand 1.0; Operand 1.0; Operand 0.5; Operand 1.0; Operand (-1.0)])
    (Parser.parse "1 1.0 .5 1. -1")

let test_parse_operators _ctx =
  assert_equal
    (Ok [ Operator Add; Operator Subtract; Operator Multiply
        ; Operator Divide; Operator Factorial; Operator Power])
    (Parser.parse "+ - * / ! ^")

let test_parse_underscore _ctx =
  assert_equal
    (Ok [Underscore])
    (Parser.parse "_")

let test_parse_error _ctx =
  assert_equal (Error (UnknownToken "&")) (Parser.parse "1 2 &")

let suite =
  "suite">:::
    [ "Parse returns error if invalid">::   test_parse_error
    ; "Parse handles extra whitespace">::   test_parse_whitespace
    ; "Parse parses operands">::            test_parse_operands
    ; "Parse parses operators">::           test_parse_operators
    ; "Parse parses underscore">::          test_parse_underscore]
