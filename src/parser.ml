type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

type error =
  | UnknownToken of string

let float_regexp =
  Str.regexp "^-?\\([0-9]+\\(\\.[0-9]*\\)?\\|\\.[0-9]+\\)$"

let string_is_float str =
  Str.string_match float_regexp str 0

let operand str =
  match string_is_float str with
  | true  -> Some (Operand (float_of_string str))
  | false -> None

let operator = function
  | "+" -> Some (Operator Operation.Add)
  | "-" -> Some (Operator Operation.Subtract)
  | "*" -> Some (Operator Operation.Multiply)
  | "/" -> Some (Operator Operation.Divide)
  | "!" -> Some (Operator Operation.Factorial)
  | "^" -> Some (Operator Operation.Power)
  | _   -> None

let underscore = function
  | "_" -> Some Underscore
  | _   -> None

let parsers = [underscore; operator; operand]

let rec try_tokenize str = function
  | p :: rest -> p str |> Option.flat_map_none (fun () -> try_tokenize str rest)
  | _         -> None

let tokenize str =
  try_tokenize str parsers |> Result.of_option (UnknownToken str)

let to_result tokens =
  match List.for_all Result.is_ok tokens with
  | true  -> Ok (List.map Result.get_exn tokens)
  | false -> Error (List.find Result.is_error tokens |> Result.get_error_exn)

let parse str =
  str
  |> Str.split (Str.regexp " ")
  |> List.filter (fun x -> x <> "")
  |> List.map tokenize
  |> to_result

let show_error = function
  | UnknownToken token -> "Unknown token " ^ token
