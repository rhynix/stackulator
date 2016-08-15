open OUnit2
open Parser

let test_parse_correct _ctx =
  assert_equal
    (ParseResult [Operand 1.0; Operand 2.0; Operator Add])
    (Parser.parse "1 2 +")

let test_parse_whitespace _ctx =
  assert_equal
    (ParseResult [Operand 1.0; Operand 2.0; Operator Add])
    (Parser.parse "1   2 +")

let test_parse_error _ctx =
  assert_equal ParseError (Parser.parse "1 2 &")

let suite =
  "suite">:::
    ["Parse returns correct items">::    test_parse_correct;
     "Parse returns error if invalid">:: test_parse_error;
     "Parse handles extra whitespace">:: test_parse_whitespace]
