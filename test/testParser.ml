open OUnit2
open Parser

let test_parse_whitespace _ctx =
  assert_equal
    (ParseResult [Operand 1.0; Operand 2.0; Operator Add])
    (Parser.parse "1   2 +")

let test_parse_operands _ctx =
  assert_equal
    (ParseResult [Operand 1.0; Operand 1.0; Operand 0.5; Operand 1.0;
                  Operand (-1.0)])
    (Parser.parse "1 1.0 .5 1. -1")

let test_parse_operators _ctx =
  assert_equal
    (ParseResult [Operator Add; Operator Subtract; Operator Multiply;
                  Operator Divide; Operator Factorial; Operator Power])
    (Parser.parse "+ - * / ! ^")

let test_parse_error _ctx =
  assert_equal ParseError (Parser.parse "1 2 &")

let suite =
  "suite">:::
    [ "Parse returns error if invalid">::   test_parse_error
    ; "Parse handles extra whitespace">::   test_parse_whitespace
    ; "Parse parses operands correctly">::  test_parse_operands
    ; "Parse parses operators correctly">:: test_parse_operators ]
