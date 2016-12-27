open OUnit2

let suite = test_list
  [ "Parser"     >::: TestParser.tests
  ; "Calculator" >::: TestCalculator.tests
  ; "Operation"  >::: TestOperation.tests
  ; "Option"     >::: TestOption.tests
  ; "Result"     >::: TestResult.tests ]

let () = run_test_tt_main suite
