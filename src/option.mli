val is_some : 'a option -> bool
val get_exn : 'a option -> 'a

val flat_map_none : (unit -> 'a option) -> 'a option -> 'a option
