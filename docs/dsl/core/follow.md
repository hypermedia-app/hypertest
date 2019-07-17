# Follow Step

Combined with `Expect Location`, the follow step can be used to request the target
URL which was the result of a create response.

## Usage

### Location header

The `Location` header is typically set on a `201 Created` response. The example below
shows how such a response from an [`Operation`] can be handled by following the new 
resource's URI set on the response:

<<< @/api-examples/hydra/follow/location-header.hydra
