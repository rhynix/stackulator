open Containers

let calculation_output tokens =
  match Calculator.calculate tokens with
  | Calculator.Result result -> Float.to_string result
  | Calculator.Error _       -> "CalculationError"

let handle_line () =
  match read_line () |> Parser.parse with
  | Parser.ParseResult tokens -> print_endline (calculation_output tokens)
  | Parser.ParseError         -> print_endline "ParseError"

let rec repl () =
  print_string "> ";
  handle_line ();
  repl ()

let terminate () =
  print_newline ();
  print_endline "Quiting..."

let () =
  Sys.catch_break true;
  try
    repl ()
  with
    | End_of_file -> terminate ()
    | Sys.Break   -> terminate ()

