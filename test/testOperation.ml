open OUnit2
open Operation

let tests = [
  "factorial with positive number" >:: (fun _ ->
    assert_equal (Ok 120.0) (factorial 5.0));

  "factorial with positive non-integer" >:: (fun _ ->
    assert_equal (Ok 120.0) (factorial 5.9));

  "factorial with zero" >:: (fun _ ->
    assert_equal (Ok 1.0) (factorial 0.0));

  "factorial with negative number" >:: (fun _ ->
    assert_equal (Error NegativeFactorial) (factorial (-1.0)));

  "add" >:: (fun _ ->
    assert_equal (Ok 6.0) (add 3.0 3.0));

  "subtract" >:: (fun _ ->
    assert_equal (Ok 3.0) (subtract 6.0 3.0));

  "multiply" >:: (fun _ ->
    assert_equal (Ok 9.0) (multiply 3.0 3.0));

  "divide" >:: (fun _ ->
    assert_equal (Ok 3.0) (divide 9.0 3.0));

  "power" >:: (fun _ ->
    assert_equal (Ok 81.0) (power 3.0 4.0))
]
