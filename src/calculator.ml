type token =
  | Operator of Operation.operator
  | Operand of float

type calculation_error =
  | TooFewOperands
  | TooMuchOperands
  | CalculationError

let push_result rest = function
  | Ok x    -> Ok (x :: rest)
  | Error _ -> Error CalculationError

let operate_on_stack operation items = match operation, items with
  | Operation.BinOp op, fst :: snd :: rest -> op snd fst |> push_result rest
  | Operation.UnOp  op, fst :: rest        -> op fst     |> push_result rest
  | _, _                                   -> Error TooFewOperands

let operate operation stack =
  Result.flat_map (operate_on_stack operation) stack

let push value stack =
  Result.map (List.cons value) stack

let handle_token = function
  | Operand  value    -> push value
  | Operator operator -> operate (Operation.operation_for_operator operator)

let stack_to_result = function
  | Ok [item] -> Ok item
  | Ok []     -> Error TooFewOperands
  | Ok _      -> Error TooMuchOperands
  | Error err -> Error err

let prepare_parser_token last_result = function
  | Parser.Operator operator -> Operator operator
  | Parser.Operand operand   -> Operand operand
  | Parser.Underscore        -> Operand last_result

let prepare last_result parser_tokens =
  List.map (prepare_parser_token last_result) parser_tokens

let calculate_to_stack =
  List.fold_left (fun stack token -> handle_token token stack) (Ok [])

let calculate tokens =
  tokens
  |> calculate_to_stack
  |> stack_to_result
