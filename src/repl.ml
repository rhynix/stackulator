type 's config = {
  handle    : string -> 's -> 's;
  terminate : 's -> unit;
  prompt    : 's -> string;
}

let run_single config state =
  print_string (config.prompt state);
  config.handle (read_line ()) state

let rec run config state =
  Sys.catch_break true;
  try
    run_single config state |> run config
  with
    | End_of_file -> (config.terminate state)
    | Sys.Break   -> (config.terminate state)
