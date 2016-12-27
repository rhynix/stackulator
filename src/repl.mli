type 's config = {
  handle    : string -> 's -> 's;
  terminate : 's -> unit;
  prompt    : 's -> string;
}

val run : 's config -> 's -> unit
