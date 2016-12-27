type error =
  | TooFewOperands
  | TooManyOperands
  | OperationError of Operation.error

type token =
  | Operator of Operation.operator
  | Operand of float

val prepare : float -> Parser.token list -> token list
val calculate : token list -> (float, error) result
val show_error : error -> string
