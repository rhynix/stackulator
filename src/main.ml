type error =
  | CalculateError of Calculator.error
  | ParseError of Parser.error

let show_error = function
  | CalculateError err -> "CalculateError: " ^ (Calculator.show_error err)
  | ParseError err     -> "ParseError: " ^ (Parser.show_error err)

type state = {
  last_result : float;
}

let calculate last parser_tokens =
  parser_tokens
  |> Calculator.prepare last
  |> Calculator.calculate
  |> Result.map_error (fun err -> CalculateError err)

let parse_and_calculate last_result input =
  input
  |> Parser.parse
  |> Result.map_error (fun err -> ParseError err)
  |> Result.flat_map (calculate last_result)

let handle_result state value =
  print_endline (string_of_float value);
  { last_result = value }

let handle_error state err =
  print_endline (show_error err);
  state

let handle input state =
  match parse_and_calculate state.last_result input with
  | Ok value  -> handle_result state value
  | Error err -> handle_error state err

let terminate _ =
  print_endline "Quiting..."

let prompt _ =
  "> "

let repl_config = {
  Repl.handle    = handle;
  Repl.terminate = terminate;
  Repl.prompt    = prompt;
}

let () =
  Repl.run repl_config { last_result = nan }
