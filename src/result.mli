val is_ok    : (_, _) result -> bool
val is_error : (_, _) result -> bool

val get_exn       : ('a, _) result -> 'a
val get_error_exn : (_, 'e) result -> 'e

val of_option : 'e -> 'a option -> ('a, 'e) result

val map      : ('a -> 'b) -> ('a, 'e) result -> ('b, 'e) result
val flat_map : ('a -> ('b, 'e) result) -> ('a, 'e) result -> ('b, 'e) result

val map_error      : ('e -> 'f) -> ('a, 'e) result -> ('a, 'f) result
val flat_map_error : ('e -> ('a, 'f) result) -> ('a, 'e) result -> ('a, 'f) result
