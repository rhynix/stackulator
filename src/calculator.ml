open Containers
open Fun

type token =
  | Operator of Operation.operator
  | Operand of float

type calculation_error =
  | TooFewOperands
  | TooMuchOperands
  | CalculationError

type stack =
  | Stack of float list
  | StackError of calculation_error

let push_result rest = function
  | Ok x    -> Stack (x :: rest)
  | Error _ -> StackError CalculationError

let operate_on_stack operation items = match operation, items with
  | Operation.BinOp op, fst :: snd :: rest -> op snd fst |> push_result rest
  | Operation.UnOp  op, fst :: rest        -> op fst     |> push_result rest
  | _, _                                   -> StackError TooFewOperands

let operate operation = function
  | Stack items -> operate_on_stack operation items
  | _ as error  -> error

let push value = function
  | Stack items           -> Stack (value :: items)
  | StackError _ as error -> error

let handle_token = function
  | Operand  value    -> push value
  | Operator operator -> operate (Operation.operation operator)

let stack_to_result = function
  | Stack [item]     -> Ok item
  | Stack []         -> Error TooFewOperands
  | Stack _          -> Error TooMuchOperands
  | StackError error -> Error error

let prepare_parser_token last_result = function
  | Parser.Operator operator -> Operator operator
  | Parser.Operand operand   -> Operand operand
  | Parser.Underscore        -> Operand last_result

let prepare last_result parser_tokens =
  List.map (prepare_parser_token last_result) parser_tokens

let calculate_to_stack =
  List.fold_left (flip handle_token) (Stack [])

let calculate = calculate_to_stack %> stack_to_result
