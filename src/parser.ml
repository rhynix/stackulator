open Containers
open Fun

type operator =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Factorial
  | Power

type token =
  | Operator of operator
  | Operand of float

type parse_result =
  | ParseResult of token list
  | ParseError

let float_regexp =
  Str.regexp "^-?\\([0-9]+\\(\\.[0-9]*\\)?\\|\\.[0-9]+\\)$"

let string_is_float str =
  Str.string_match float_regexp str 0

let operand str =
  match string_is_float str with
  | true  -> Some (Operand (float_of_string str))
  | false -> None

let operator = function
  | "+" -> Some (Operator Add)
  | "-" -> Some (Operator Subtract)
  | "*" -> Some (Operator Multiply)
  | "/" -> Some (Operator Divide)
  | "!" -> Some (Operator Factorial)
  | "^" -> Some (Operator Power)
  | _   -> None

let underscore result = function
  | "_" -> Some (Operand result)
  | _   -> None

let rec try_parse_token str = function
  | p :: parsers -> (
    match p str with
    | Some token -> Some token
    | None       -> try_parse_token str parsers)
  | _ -> None

let tokenize underscore_result str =
  try_parse_token str [underscore underscore_result; operator; operand]

let to_result maybe_tokens =
  match List.for_all Option.is_some maybe_tokens with
  | true  -> ParseResult (List.map Option.get_exn maybe_tokens)
  | false -> ParseError

let parse underscore_result =
  Str.split (Str.regexp " ")
  %> List.filter (fun x -> x <> "")
  %> List.map (tokenize underscore_result)
  %> to_result
