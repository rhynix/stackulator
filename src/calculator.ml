open Containers
open Fun

type calculation_error =
  | TooFewOperands
  | TooMuchOperands
  | CalculationError

type stack =
  | Stack of float list
  | StackError of calculation_error

type operation =
  | UnOp of (float -> Operation.result)
  | BinOp of (float -> float -> Operation.result)

type result =
  | Result of float
  | Error of calculation_error

let operation = function
  | Parser.Add       -> BinOp Operation.add
  | Parser.Subtract  -> BinOp Operation.subtract
  | Parser.Multiply  -> BinOp Operation.multiply
  | Parser.Divide    -> BinOp Operation.divide
  | Parser.Power     -> BinOp Operation.power
  | Parser.Factorial -> UnOp  Operation.factorial

let push_result tail = function
  | Operation.Result x -> Stack (x :: tail)
  | Operation.Error    -> StackError CalculationError

let operate operation stack = match operation, stack with
  | BinOp op, Stack (fst :: snd :: tl) -> push_result tl (op snd fst)
  | UnOp  op, Stack (fst :: tl)        -> push_result tl (op fst)
  | _,        Stack _                  -> StackError TooFewOperands
  | _,        StackError error         -> StackError error

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
