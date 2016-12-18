type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

type parse_result =
  | ParseResult of token list
  | ParseError

val parse : float -> string -> parse_result
