let map f = function
  | Ok value  -> Ok (f value)
  | Error err -> Error err

let flat_map f = function
  | Ok value  -> f value
  | Error err -> Error err

let map_error f = function
  | Ok value  -> Ok value
  | Error err -> Error (f err)
