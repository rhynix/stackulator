open OUnit2

let suite =
  "suite">:::
    [ TestParser.suite
    ; TestCalculator.suite
    ; TestOperation.suite
    ; TestOption.suite
    ; TestResult.suite ]

let () = run_test_tt_main suite
