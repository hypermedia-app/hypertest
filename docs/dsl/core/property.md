# Property Step

A property step lets the test author inspect properties or attributes of resource
representations.

## Syntax

* Property steps are valid where representation is the context.
* Property steps are not valid on top level.

## Usage

### Strict property check

A test may require that a given property is present. If not, then a test failure should be
reported.

<<< @/api-examples/core/property/strict-check.api

### Asserting literal property value

An optional parameter can be provided, which instructs the client to compare it with 
the actual value of the property.

<<< @/api-examples/core/property/assert-value.api

:::tip
Supported are exact comparison of integers, decimals, booleans and strings.
:::

### Step into nested resource

A property step can also be a block.

If a property is not necessary for the success of the test scenario, it may be treated as 
optional, by using `With` modifier instead of `Expect` modifier.

<<< @/api-examples/core/property/nested-resource.api
