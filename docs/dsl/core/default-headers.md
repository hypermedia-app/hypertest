# Scenario Headers Block

At the top of a hypertest scenario a `HEADERS` block may be defined which defines HTTP headers
added to every request within this scenario.

This is useful for example to pass authentication information.

## Remarks

Any field name can used multiple times even if the given header's semantics does not allow it. It is up to
the test runner to correctly set them on the server request.

## Example

<<< @/api-examples/core/default-headers/auth-and-cookies.api
