let is_some = function
  | Some _ -> true
  | None   -> false

let get_exn = function
  | Some value -> value
  | None       -> invalid_arg "Option.get_exn"

let flat_map_none f = function
  | Some value -> Some value
  | None       -> f ()
