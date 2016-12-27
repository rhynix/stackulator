type error =
  | CalculateError of Calculator.error
  | ParseError

let show_error = function
  | CalculateError err -> "CalculateError: " ^ (Calculator.show_error err)
  | ParseError         -> "ParseError"

let calculate last parser_tokens =
  parser_tokens
  |> Calculator.prepare last
  |> Calculator.calculate
  |> Result.map_error (fun err -> CalculateError err)

let parse_and_calculate_line last_result () =
  read_line ()
  |> Parser.parse
  |> Result.map_error (fun _ -> ParseError)
  |> Result.flat_map (calculate last_result)

let rec repl last_result () =
  print_string "> ";
  match parse_and_calculate_line last_result () with
  | Ok value  -> handle_result value
  | Error err -> handle_error last_result err

and handle_result value =
  print_endline (string_of_float value);
  repl value ()

and handle_error last_result err =
  print_endline (show_error err);
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
