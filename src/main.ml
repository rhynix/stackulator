open Containers

type final_result =
  | Ok    of float
  | Error of string

let calculate tokens =
  match Calculator.calculate tokens with
  | Calculator.Result result -> Ok    result
  | Calculator.Error _       -> Error "CalculationError"

let parse_and_calculate_lane last_result () =
  match read_line () |> Parser.parse last_result with
  | Parser.ParseResult tokens -> calculate tokens
  | Parser.ParseError         -> Error "ParseError"

let rec repl last_result () =
  print_string "> ";
  match parse_and_calculate_line last_result () with
  | Ok result   -> handle_result result
  | Error error -> handle_error last_result error

and handle_result result =
  print_endline (Float.to_string result);
  repl result ()

and handle_error last_result error =
  print_endline error;
  repl last_result ()

let terminate () =
  print_newline ();
  print_endline "Quiting..."

let () =
  Sys.catch_break true;
  try
    repl 0.0 ()
  with
    | End_of_file -> terminate ()
    | Sys.Break   -> terminate ()

