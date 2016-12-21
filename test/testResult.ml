open OUnit2

let test_map_ok _ctx =
  assert_equal (Ok 2) (Result.map ((+) 1) (Ok 1))

let test_map_error _ctx =
  assert_equal (Error ()) (Result.map ((+) 1) (Error ()))

let test_flat_map_with_ok_ok _ctx =
  assert_equal (Ok 2) (Result.flat_map (fun x -> (Ok (x + 1))) (Ok 1))

let test_flat_map_with_error_ok _ctx =
  assert_equal (Error ()) (Result.flat_map (fun x -> (Ok (x + 1))) (Error ()))

let test_flat_map_with_ok_error _ctx =
  assert_equal (Error ()) (Result.flat_map (fun x -> Error ()) (Ok 1))

let test_flat_map_with_error_error _ctx =
  assert_equal (Error ()) (Result.flat_map (fun x -> Error ()) (Error ()))

let test_map_error_ok _ctx =
  assert_equal (Ok 1) (Result.map_error ((+) 1) (Ok 1))

let test_map_error_error _ctx =
  assert_equal (Error 2) (Result.map_error ((+) 1) (Error 1))

let test_flat_map_error_with_ok_ok _ctx =
  assert_equal (Ok 1) (Result.flat_map_error (fun x -> (Ok (x + 1))) (Ok 1))

let test_flat_map_error_with_error_ok _ctx =
  assert_equal (Ok 2) (Result.flat_map_error (fun x -> (Ok (x + 1))) (Error 1))

let test_flat_map_error_with_ok_error _ctx =
  assert_equal (Ok 1) (Result.flat_map_error (fun x -> Error ()) (Ok 1))

let test_flat_map_error_with_error_error _ctx =
  assert_equal (Error 2) (Result.flat_map_error (fun x -> Error 2) (Error 1))

let suite =
  "suite">:::
    [ "Map ok">::                      test_map_ok
    ; "Map error">::                   test_map_error
    ; "Flat map ok, ok">::             test_flat_map_with_ok_ok
    ; "Flat map ok, error">::          test_flat_map_with_error_ok
    ; "Flat map error, ok">::          test_flat_map_with_ok_error
    ; "Flat map error, error">::       test_flat_map_with_error_error
    ; "Map error ok">::                test_map_error_ok
    ; "Map error error">::             test_map_error_error
    ; "Flat map error ok, ok">::       test_flat_map_error_with_ok_ok
    ; "Flat map error ok, error">::    test_flat_map_error_with_ok_error
    ; "Flat map error error, ok">::    test_flat_map_error_with_error_ok
    ; "Flat map error error, error">:: test_flat_map_error_with_error_error
    ]
