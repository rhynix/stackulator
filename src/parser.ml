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
  Str.regexp "^\\([0-9]+\\(\\.[0-9]*\\)?\\|\\.[0-9]+\\)$"

let string_is_float str =
  Str.string_match float_regexp str 0

let operator = function
  | "+" -> Some (Operator Add)
  | "-" -> Some (Operator Subtract)
  | "*" -> Some (Operator Multiply)
  | "/" -> Some (Operator Divide)
  | "!" -> Some (Operator Factorial)
  | "^" -> Some (Operator Power)
  | _   -> None

let tokenize str =
  match string_is_float str with
  | true  -> Some (Operand (float_of_string str))
  | false -> operator str

let to_result maybe_tokens =
  match List.for_all Option.is_some maybe_tokens with
  | true  -> ParseResult (List.map Option.get_exn maybe_tokens)
  | false -> ParseError

let parse =
  Str.split (Str.regexp " ")
  %> List.filter (fun x -> x <> "")
  %> List.map tokenize
  %> to_result
