type token =
  | Operator of Operation.operator
  | Operand of float

type error =
  | TooFewOperands
  | TooManyOperands
  | OperationError of Operation.error

let push_result result stack =
  result
  |> Result.map (fun value -> value :: stack)
  |> Result.map_error (fun err -> OperationError err)

let operate_on_stack operation items = match operation, items with
  | Operation.BinOp op, fst :: snd :: stack -> push_result (op snd fst) stack
  | Operation.UnOp  op, fst :: stack        -> push_result (op fst)     stack
  | _, _                                    -> Error TooFewOperands

let operate operation stack_result =
  Result.flat_map (operate_on_stack operation) stack_result

let push value stack_result =
  Result.map (List.cons value) stack_result

let handle_token = function
  | Operand  value    -> push value
  | Operator operator -> operate (Operation.operation_for_operator operator)

let stack_to_result = function
  | [item] -> Ok item
  | []     -> Error TooFewOperands
  | _      -> Error TooManyOperands

let calculate_to_stack_result tokens =
  List.fold_left (fun stack_result token ->
    handle_token token stack_result
  ) (Ok []) tokens

let calculate tokens =
  tokens
  |> calculate_to_stack_result
  |> Result.flat_map stack_to_result

let prepare_parser_token last_result = function
  | Parser.Operator operator -> Operator operator
  | Parser.Operand operand   -> Operand operand
  | Parser.Underscore        -> Operand last_result

let prepare_tokens last_result parser_tokens =
  List.map (prepare_parser_token last_result) parser_tokens

let show_error = function
  | TooFewOperands     -> "Too few operands"
  | TooManyOperands    -> "Too many operands"
  | OperationError err -> Operation.show_error err
