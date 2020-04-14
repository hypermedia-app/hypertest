# Link Step

Hydra extends the link's semantics by adding the possibility to link a URI template which has to be filled in by the client.

Hydra's DSL dialect facilitates by extending the syntax of the link step with a template variables section as a key/value set.

## Syntax

* Keys are URIs of prefixed names
* Values are string
* Same key can appear multiple times

## Usage

<<< @/api-examples/hydra/link/templated.hydra
