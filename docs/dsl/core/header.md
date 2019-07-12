# Header step

Header step is a way to inspect [HTTP headers][hh] in a generic way.

[hh]: https://developer.mozilla.org/docs/Web/HTTP/Headers

## Syntax

* Header statement is only valid where response is the context
* The header name is case-insensitive, as the HTTP header fields are

## Usage

### Check link exists on the response

<<< @/api-examples/core/header/exists.api

### Text header value

To check that a header contains a specific value it is possible to do an exact
comparison or regular expression matching.

<<< @/api-examples/core/header/assert-value.api

:::tip
The regular expression string is not parsed as the exact implementation would
depend on the test runner.
:::

### Capture header value

It is also possible to create a "variable" containing the header's value, so that
it can be used in subsequent steps.

<<< @/api-examples/core/header/capture-value.api
