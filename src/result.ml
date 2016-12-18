let map f = function
  | Ok value  -> Ok (f value)
  | Error err -> Error err

let flat_map f = function
  | Ok value  -> f value
  | Error err -> Error err

let map_or_error f default = function
  | Ok value -> Ok (f value)
  | Error _  -> Error default
