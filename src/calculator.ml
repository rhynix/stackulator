open Containers
open Fun

type calculation_error =
  | TooFewOperands
  | TooMuchOperands

type stack =
  | Stack of float list
  | StackError of calculation_error

type result =
  | Result of float
  | Error of calculation_error

let operation = function
  | Parser.Add      -> ( +. )
  | Parser.Subtract -> ( -. )
  | Parser.Multiply -> ( *. )
  | Parser.Divide   -> ( /. )

let operate operation = function
  | Stack (fst :: snd :: tl) -> Stack ((operation snd fst) :: tl)
  | Stack _                  -> StackError TooFewOperands
  | StackError _ as error    -> error

let push value = function
  | Stack items           -> Stack (value :: items)
  | StackError _ as error -> error

let handle_token = function
  | Parser.Operand  value    -> push value
  | Parser.Operator operator -> operate (operation operator)

let stack_to_result = function
  | Stack [item]     -> Result item
  | Stack []         -> Error TooFewOperands
  | Stack _          -> Error TooMuchOperands
  | StackError error -> Error error

let calculate_to_stack =
  List.fold_left (flip handle_token) (Stack [])

let calculate = calculate_to_stack %> stack_to_result
