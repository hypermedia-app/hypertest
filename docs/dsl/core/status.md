# Status Step

Status is a statement which lets test authors assert that a request returns a
specific [HTTP status code](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml)
code in its response.

## Syntax

* Status steps are valid where response is the context.

## Usage

### Check the result of a request

The example below combines `Expect Status` statement with [`Hydra` subgrammar](../hydra).

<<< @/api-examples/hydra/operation/top-level.hydra
