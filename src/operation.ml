type result =
  | Result of float
  | Error

let factorial n =
  let rec factorial_of_int acc = function
    | n when n > 0 -> factorial_of_int (acc * n) (n - 1)
    | n when n = 0 -> Result (float_of_int acc)
    | n            -> Error in
  int_of_float n |> factorial_of_int 1

let add      x y = Result (x +. y)
let subtract x y = Result (x -. y)
let multiply x y = Result (x *. y)
let divide   x y = Result (x /. y)
let power    x y = Result (x ** y)