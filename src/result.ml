let map f = function
  | Ok value  -> Ok (f value)
  | Error err -> Error err

let flat_map f = function
  | Ok value  -> f value
  | Error err -> Error err
