open OUnit2

let suite =
  "suite">:::
    [ TestParser.suite
    ; TestCalculator.suite
    ; TestCalculations.suite ]

let () = run_test_tt_main suite
