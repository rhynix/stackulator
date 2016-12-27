type 's config = {
  handle    : string -> 's -> 's;
  terminate : 's -> unit;
  prompt    : 's -> string;
}

let terminate config state =
  config.terminate state;
  exit 0

let rec run_single config state =
  match LNoise.linenoise (config.prompt state) with
  | None       -> terminate config state
  | Some input -> config.handle input state |> run_single config

let rec run config state =
  Sys.catch_break true;
  try
    run_single config state
  with
    | End_of_file -> (config.terminate state)
    | Sys.Break   -> (config.terminate state)
