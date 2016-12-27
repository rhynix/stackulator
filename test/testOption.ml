open OUnit2

let tests =  [
  "is_some with some" >:: (fun _ ->
    assert_equal true (Option.is_some (Some true)));

  "is_some with none" >:: (fun _ ->
    assert_equal false (Option.is_some None));

  "get_exn with some" >:: (fun _ ->
    assert_equal true (Option.get_exn (Some true)));

  "get_exn with none" >:: (fun _ ->
    assert_raises (Invalid_argument "Option.get_exn") (fun () ->
      (Option.get_exn None)));

  "flat_map_none with some" >:: (fun _ ->
    assert_equal (Some 1) (Option.flat_map_none (fun () -> Some 2) (Some 1)));

  "flat_map_none with none" >:: (fun _ ->
    assert_equal (Some 2) (Option.flat_map_none (fun () -> Some 2) None));
]
