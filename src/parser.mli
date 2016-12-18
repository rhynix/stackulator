type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

val parse : string -> (token list, unit) result
