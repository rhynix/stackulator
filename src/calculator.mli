type calculation_error =
  | TooFewOperands
  | TooMuchOperands
  | CalculationError

type token =
  | Operator of Operation.operator
  | Operand of float

val prepare : float -> Parser.token list -> token list
val calculate : token list -> (float, calculation_error) result
