type calculation_error =
  | TooFewOperands
  | TooMuchOperands
  | CalculationError

type token =
  | Operator of Operation.operator
  | Operand of float

type result =
  | Result of float
  | Error of calculation_error

val prepare : float -> Parser.token list -> token list
val calculate : token list -> result
