## Constrained blocks

Some blocks can be executed conditionally based on constraining the
response or representation.

Currently it is possible to constrain [`Class`](../dsl/core/class), [`Link`](../dsl/core/link) and
[`Property`](../dsl/core/property) blocks by setting conditions on HTTP Status code
or property values.

A generic syntax is

```
'When' ('Property' | 'Status') Not? Operator Value 
```

Possible operators are:

1. Strict equality
1. Inequality
1. Regular expression
1. Custom code (to be parsed by test runner)

Possible values are string, numeric and boolean.

Multiple `When` statements should be joined with a logical `AND` operator
by the runner, ie. a block should be executed only when all conditions are
satisfied.

## Examples

### Only execute Class when property matches

<<< @/api-examples/core/class/gated.api

### Constrain link block based on status code

<<< @/api-examples/core/link/gated.api
