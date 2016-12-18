type result =
  | Result of float
  | Error

type operator =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Factorial
  | Power

type operation =
  | UnOp of (float -> result)
  | BinOp of (float -> float -> result)

val operation : operator -> operation

val factorial : float -> result
val add : float -> float -> result
val subtract : float -> float -> result
val multiply : float -> float -> result
val divide : float -> float -> result
val power : float -> float -> result
