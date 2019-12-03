# Entrypoint Statement

It may be desired to start the test scenario by requesting

## Remarks

There can be only one `ENTRYPOINT` statement at the top of a scenario document.

The test runner should apply it relative to the base URL provided as the command parameter.

## Example

When running the below against an API under `http://tech.blog/api/`, the first requested resource would be
`http://tech.blog/api/some/article`.

<<< @/api-examples/core/entrypoint/custom-entry.api
