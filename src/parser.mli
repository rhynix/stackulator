type operator =
  | Add
  | Subtract
  | Multiply
  | Divide

type token =
  | Operator of operator
  | Operand of float

type parse_result =
  | ParseResult of token list
  | ParseError

val parse : string -> parse_result
