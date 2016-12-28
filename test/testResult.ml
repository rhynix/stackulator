open OUnit2

let tests = [
  "is_ok with ok" >:: (fun _ ->
    assert_equal true (Result.is_ok (Ok ())));

  "is_ok with error" >:: (fun _ ->
    assert_equal false (Result.is_ok (Error ())));

  "is_error with ok" >:: (fun _ ->
    assert_equal false (Result.is_error (Ok ())));

  "is_error with error" >:: (fun _ ->
    assert_equal true (Result.is_error (Error ())));

  "get_exn with ok" >:: (fun _ ->
    assert_equal 1 (Result.get_exn (Ok 1)));

  "get_exn with error" >:: (fun _ ->
    assert_raises (Invalid_argument "Result.get_exn") (fun () ->
      Result.get_exn (Error ())));

  "get_error_exn with ok" >:: (fun _ ->
    assert_raises (Invalid_argument "Result.get_error_exn") (fun () ->
      Result.get_error_exn (Ok ())));

  "get_error_exn with error" >:: (fun _ ->
    assert_equal 1 (Result.get_error_exn (Error 1)));

  "of_option with some" >:: (fun _ ->
    assert_equal (Ok 1) (Result.of_option "Error" (Some 1)));

  "of_option with none" >:: (fun _ ->
    assert_equal (Error "Error") (Result.of_option "Error" None));

  "map with ok" >:: (fun _ ->
    assert_equal (Ok 2) (Result.map ((+) 1) (Ok 1)));

  "map with error" >:: (fun _ ->
    assert_equal (Error ()) (Result.map ((+) 1) (Error ())));

  "flat_map with ok, returning ok" >:: (fun _ ->
    assert_equal (Ok 2) (Result.flat_map (fun x -> Ok (x + 1)) (Ok 1)));

  "flat_map with error, returning ok" >:: (fun _ ->
    assert_equal (Error ()) (Result.flat_map (fun x -> Ok (x + 1)) (Error ())));

  "flat_map with ok, returning error" >:: (fun _ ->
    assert_equal (Error 2) (Result.flat_map (fun x -> Error (x + 1)) (Ok 1)));

  "flat_map with error, returning error" >:: (fun _ ->
    assert_equal (Error 1) (Result.flat_map (fun x -> Error (x + 1)) (Error 1)));

  "map_error with ok" >:: (fun _ ->
    assert_equal (Ok 1) (Result.map_error ((+) 1) (Ok 1)));

  "map_error with error" >:: (fun _ ->
    assert_equal (Error 2) (Result.map_error ((+) 1) (Error 1)));

  "flat_map_error with ok, returning ok" >:: (fun _ ->
    assert_equal (Ok 1) (Result.flat_map_error (fun x -> Ok (x + 1)) (Ok 1)));

  "flat_map_error with error, returning ok" >:: (fun _ ->
    assert_equal (Ok 2) (Result.flat_map_error (fun x -> Ok (x + 1)) (Error 1)));

  "flat_map_error with ok, returning error" >:: (fun _ ->
    assert_equal (Ok 1) (Result.flat_map_error (fun x -> Error (x + 1)) (Ok 1)));

  "flat_map_error with error, returning error" >:: (fun _ ->
    assert_equal (Error 2) (Result.flat_map_error (fun x -> Error (x + 1)) (Error 1)));
]
