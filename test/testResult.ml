open OUnit2

let test_is_ok_ok _ctx =
  assert_equal true (Result.is_ok (Ok ()))

let test_is_ok_error _ctx =
  assert_equal false (Result.is_ok (Error ()))

let test_is_error_ok _ctx =
  assert_equal false (Result.is_error (Ok ()))

let test_is_error_error _ctx =
  assert_equal true (Result.is_error (Error ()))

let test_get_exn_ok _ctx =
  assert_equal 1 (Result.get_exn (Ok 1))

let test_get_exn_error _ctx =
  assert_raises (Invalid_argument "Result.get_exn") (fun () ->
    Result.get_exn (Error ())
  )

let test_get_error_exn_ok _ctx =
  assert_equal 1 (Result.get_error_exn (Error 1))

let test_get_error_exn_error _ctx =
  assert_raises (Invalid_argument "Result.get_error_exn") (fun () ->
    Result.get_error_exn (Ok ())
  )

let test_of_option_some _ctx =
  assert_equal (Ok 1) (Result.of_option "Error" (Some 1))

let test_of_option_none _ctx =
  assert_equal (Error "Error") (Result.of_option "Error" None)

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
    [ "Is ok ok">::                    test_is_ok_ok
    ; "Is ok error">::                 test_is_ok_error
    ; "Is error ok">::                 test_is_error_ok
    ; "Is error error">::              test_is_error_error
    ; "Get exn ok">::                  test_get_exn_ok
    ; "Get exn error">::               test_get_exn_error
    ; "Get error exn ok">::            test_get_error_exn_ok
    ; "Get error exn error">::         test_get_error_exn_error
    ; "Map ok">::                      test_map_ok
    ; "Map error">::                   test_map_error
    ; "Of option some">::              test_of_option_some
    ; "Of option none">::              test_of_option_none
    ; "Flat map ok, ok">::             test_flat_map_with_ok_ok
    ; "Flat map ok, error">::          test_flat_map_with_error_ok
    ; "Flat map error, ok">::          test_flat_map_with_ok_error
    ; "Flat map error, error">::       test_flat_map_with_error_error
    ; "Map error ok">::                test_map_error_ok
    ; "Map error error">::             test_map_error_error
    ; "Flat map error ok, ok">::       test_flat_map_error_with_ok_ok
    ; "Flat map error ok, error">::    test_flat_map_error_with_ok_error
    ; "Flat map error error, ok">::    test_flat_map_error_with_error_ok
    ; "Flat map error error, error">:: test_flat_map_error_with_error_error ]
