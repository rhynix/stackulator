type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

type error =
  | UnknownToken of string

val parse : string -> (token list, error) result
val show_error : error -> string
