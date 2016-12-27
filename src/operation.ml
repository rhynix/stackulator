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

let factorial n =
  let rec factorial_of_int acc = function
    | n when n > 0 -> factorial_of_int (acc * n) (n - 1)
    | n when n = 0 -> Ok (float_of_int acc)
    | n            -> Error NegativeFactorial in
  int_of_float n |> factorial_of_int 1

let add      x y = Ok (x +. y)
let subtract x y = Ok (x -. y)
let multiply x y = Ok (x *. y)
let divide   x y = Ok (x /. y)
let power    x y = Ok (x ** y)

let operation_for_operator = function
  | Add       -> BinOp add
  | Subtract  -> BinOp subtract
  | Multiply  -> BinOp multiply
  | Divide    -> BinOp divide
  | Power     -> BinOp power
  | Factorial -> UnOp  factorial

let show_error = function
  | NegativeFactorial -> "Factorial of negative number"
