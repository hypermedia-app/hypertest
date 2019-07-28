# Invoke Block

Use the invoke block to define operation's request message and 

## Syntax

* `Invoke` keyword can be followed by one or two blocks, to set up request message and response steps 

## Usage

### Only check response message

<<< @/api-examples/hydra/operation/top-level.hydra

### Setting request headers

<<< @/api-examples/hydra/invoke/request-headers.hydra

### Sending request body

Request body can be set in two ways. One is to provide the contents inline,
delimited by triple backticks similarly to markdown.

:::warning
The parser preserves all whitspace except leading a trailing. If whitespace is
signinficant load the body from a file.
:::

<<< @/api-examples/hydra/invoke/request-inline-body.hydra

Second way is to reference a file whose contents will be sent.

<<< @/api-examples/hydra/invoke/request-file-body.hydra
