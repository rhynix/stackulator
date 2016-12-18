type operator =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Factorial
  | Power

type operation =
  | UnOp of (float -> (float, unit) result)
  | BinOp of (float -> float -> (float, unit) result)

val operation_for_operator : operator -> operation

val factorial : float -> (float, unit) result
val add :       float -> float -> (float, unit) result
val subtract :  float -> float -> (float, unit) result
val multiply :  float -> float -> (float, unit) result
val divide :    float -> float -> (float, unit) result
val power :     float -> float -> (float, unit) result
