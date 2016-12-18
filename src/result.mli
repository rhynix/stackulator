val map : ('a -> 'b) -> ('a, 'e) result -> ('b, 'e) result
val flat_map : ('a -> ('b, 'e) result) -> ('a, 'e) result -> ('b, 'e) result
val map_or_error : ('a -> 'b) -> 'f -> ('a, 'e) result -> ('b, 'f) result
