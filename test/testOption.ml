open OUnit2

let test_is_some_some _ctx =
  assert_bool "is_some of some is true" (Option.is_some (Some true))

let test_is_some_none _ctx =
  assert_bool "is_some of none is false" (not (Option.is_some None))

let test_get_exn_some _ctx =
  assert_equal true (Option.get_exn (Some true))

let test_get_exn_none _ctx =
  assert_raises (Invalid_argument "Option.get_exn") (fun () ->
    (Option.get_exn None)
  )

let suite =
  "suite">:::
    [ "is_some for some">:: test_is_some_some
    ; "is_some for none">:: test_is_some_none
    ; "get_exn for some">:: test_get_exn_some
    ; "get_exn for none">:: test_get_exn_none ]
