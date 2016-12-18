type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

type parse_result =
  | ParseResult of token list
  | ParseError

val parse : string -> parse_result
