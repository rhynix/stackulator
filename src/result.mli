val map : ('a -> 'b) -> ('a, 'e) result -> ('b, 'e) result
val flat_map : ('a -> ('b, 'e) result) -> ('a, 'e) result -> ('b, 'e) result
val map_error : ('e -> 'f) -> ('a, 'e) result -> ('a, 'f) result
