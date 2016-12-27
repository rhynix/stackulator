type operator =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Factorial
  | Power

type error =
  | NegativeFactorial

type operation =
  | UnOp of (float -> (float, error) result)
  | BinOp of (float -> float -> (float, error) result)

val operation_for_operator : operator -> operation
val show_error : error -> string

val factorial : float -> (float, error) result
val add       : float -> float -> (float, error) result
val subtract  : float -> float -> (float, error) result
val multiply  : float -> float -> (float, error) result
val divide    : float -> float -> (float, error) result
val power     : float -> float -> (float, error) result
