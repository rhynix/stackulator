type result =
  | Result of float
  | Error

val factorial : float -> result
val add : float -> float -> result
val subtract : float -> float -> result
val multiply : float -> float -> result
val divide : float -> float -> result
