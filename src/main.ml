let calculate last parser_tokens =
  match parser_tokens |> Calculator.prepare last |> Calculator.calculate with
  | Ok result -> Ok result
  | Error _   -> Error "CalculationError"

let parse_and_calculate_line last_result () =
  match read_line () |> Parser.parse with
  | Ok tokens -> calculate last_result tokens
  | Error _   -> Error "ParseError"

let rec repl last_result () =
  print_string "> ";
  match parse_and_calculate_line last_result () with
  | Ok result   -> handle_result result
  | Error error -> handle_error last_result error

and handle_result result =
  print_endline (string_of_float result);
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
    repl nan ()
  with
    | End_of_file -> terminate ()
    | Sys.Break   -> terminate ()
