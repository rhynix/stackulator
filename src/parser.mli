type operator =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Factorial
  | Power

type token =
  | Operator of operator
  | Operand of float

type parse_result =
  | ParseResult of token list
  | ParseError

val parse : float -> string -> parse_result
