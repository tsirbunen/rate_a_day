# RATE A DAY

## What's it all about?

Sometimes after a miserable day or two at work it feels that it's _always_ miserable.
Remembering the good days might be difficult.
**RATE A DAY** helps with this. After each working day, evaluate your day on two 2-point scales:

1. Were you mostly happy or unhappy today?
2. Did you learn anything new today?

If you keep recording your daily evaluations, then, next time you feel miserable, you can view your earlier evaluation history and see how frequent the miserable days actually are.

## Usage

### To generate built_value model files

`flutter packages pub run build_runner build`

### To run tests

To run all unit tests and widget tests
`flutter test test/tests`
To run a single unit or widget test file, for example the unit test file "date_time_util_test.dart"
`flutter test test/unit_tests/date_time_util_test.dart`
Integration tests are in a folder different from unit and widget tests. To run integration tests
`flutter test integration_test`
Note: running integration tests is very time consuming as the app is built every time anew.
