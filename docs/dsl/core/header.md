# Header step

Header step is a way to inspect [HTTP headers][hh] in a generic way.

[hh]: https://developer.mozilla.org/docs/Web/HTTP/Headers

## Syntax

* Header statement is only valid where response is the context
* The header name is case-insensitive, as the HTTP header fields are

## Usage

### Check that header exists on the response

<<< @/api-examples/core/header/exists.api

### Test header value

To check that a header contains a specific value it is possible to do an exact
comparison or regular expression matching.

<<< @/api-examples/core/header/assert-value.api

:::tip
The regular expression itself is not parsed as the exact implementation would
depend on the test runner and its platform.
:::

### Capture header value

It is also possible to create a "variable" containing the header's value, so that
it can be used in subsequent steps.

<<< @/api-examples/core/header/capture-value.api
