Analyze test coverage and write tests for uncovered code.

## Steps

1. Detect test framework (jest, vitest, pytest, go test, etc.)
2. Run tests with coverage: `npx jest --coverage` or equivalent
3. Identify files/functions with low coverage
4. Write meaningful tests for critical uncovered paths
5. Focus on: edge cases, error handling, business logic
6. Re-run coverage to show improvement

Priority: $ARGUMENTS (or auto-detect critical paths)
