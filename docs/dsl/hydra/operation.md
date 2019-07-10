# Operation Step

Operation steps let the test authors perform requests to the server based on the
[`SupportedOperations`](http://www.hydra-cg.com/spec/latest/core/#example-9-defining-a-class-and-documenting-its-supported-operations)  
advertised by Hydra API Documentation or inlined in the resource representation. 

## Syntax

* Operation steps are valid where representation is the context.
* Operation steps are also valid on top level.
* Operation has a single child step `Invoke`.
* `Invoke` accepts any child step which applies to responses and representations.

## Usage

### Top-level scenario step

The simplest use of an operation is to place it in the root of a test scenario so that
it will be invoked as soon as any resource representation which supports it is analysed.

```
With Operation "http://example.com/vocab#CreateIssueOperation" {
    Invoke {
        Expect Status 201
    }
}
```

### Context-specific operation

An operation can be limited in scope to a specific [`Class`](../core/class) or
anywhere else where representation steps are valid, such as [`Property`](../core/property).
Thus, the child invocations will only be performed when the operation is found within
a specific client state.

```
With Class "http://example.com/vocab#Task" {
    With Operation "http://example.com/vocab#CancelTask" {
        Invoke {
            Expect Status 204
        }
    }
}
```

### Making operation mandatory

Just like with the [`Property`](../core/property) step, a missing operation can be
reported as a test failure by swapping `With` modifier for `Expect`.

```
With Class "http://example.com/vocab#Task" {
    
    // Will report error if operation is not found
    Expect Operation "http://example.com/vocab#CancelTask" {
        Invoke {
            Expect Status 204
        }
    }
}
```
