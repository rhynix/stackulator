let is_ok = function
  | Ok _    -> true
  | Error _ -> false

let is_error = function
  | Ok _    -> false
  | Error _ -> true

let get_exn = function
  | Ok value -> value
  | Error _  -> invalid_arg "Result.get_exn"

let get_error_exn = function
  | Ok _       -> invalid_arg "Result.get_error_exn"
  | Error err  -> err

let of_option err = function
  | Some value -> Ok value
  | None       -> Error err

let map f = function
  | Ok value  -> Ok (f value)
  | Error err -> Error err

let flat_map f = function
  | Ok value  -> f value
  | Error err -> Error err

let map_error f = function
  | Ok value  -> Ok value
  | Error err -> Error (f err)

let flat_map_error f = function
  | Ok value  -> Ok value
  | Error err -> f err
