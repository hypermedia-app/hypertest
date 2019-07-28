# Operation Step

Operation steps let the test authors perform requests to the server based on the
[`SupportedOperations`](http://www.hydra-cg.com/spec/latest/core/#example-9-defining-a-class-and-documenting-its-supported-operations)  
advertised by Hydra API Documentation or inlined in the resource representation. 

## Syntax

* Operation steps are valid where representation is the context.
* Operation steps are also valid on top level.
* Operation has a single child step [`Invoke`](./invoke).

## Usage

### Top-level scenario step

The simplest use of an operation is to place it in the root of a test scenario so that
it will be invoked as soon as any resource representation which supports it is analysed.

<<< @/api-examples/hydra/operation/top-level.hydra

### Context-specific operation

An operation can be limited in scope to a specific [`Class`](../core/class) or
anywhere else where representation steps are valid, such as [`Property`](../core/property).
Thus, the child invocations will only be performed when the operation is found within
a specific client state.

<<< @/api-examples/hydra/operation/context-specific.hydra

### Making operation mandatory

Just like with the [`Property`](../core/property) step, a missing operation can be
reported as a test failure by swapping `With` modifier for `Expect`.

<<< @/api-examples/hydra/operation/mandatory-operation.hydra

Child invocations can also be skipped to only check that the operation is
supported. If a top-level `With Operation` is found it will still be executed. 

<<< @/api-examples/hydra/operation/no-invocations.hydra
