open OUnit2

let suite =
  "suite">:::
    [ TestParser.suite
    ; TestCalculator.suite
    ; TestOperation.suite ]

let () = run_test_tt_main suite
