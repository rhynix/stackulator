type token =
  | Operator of Operation.operator
  | Operand  of float
  | Underscore

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

let rec tokenize parsers str = match parsers with
  | p :: rest -> p str |> Option.flat_map_none (fun () -> tokenize rest str)
  | _         -> None

let to_result maybe_tokens =
  match List.for_all Option.is_some maybe_tokens with
  | true  -> Ok (List.map Option.get_exn maybe_tokens)
  | false -> Error ()

let parse str =
  str
  |> Str.split (Str.regexp " ")
  |> List.filter (fun x -> x <> "")
  |> List.map (tokenize parsers)
  |> to_result
