type calculation_error =
  | TooFewOperands
  | TooMuchOperands

type result =
  | Result of float
  | Error of calculation_error

val calculate : Parser.token list -> result
