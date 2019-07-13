# Link Step

Link steps let test scenarios traverse between resource representations in order to
analyse those linked resources.

:::tip
It is up to the runner implementation to decide whether the link step should
only apply to links found in bodies (such as [HAL's][hal] `_links` or
HTML's [anchor element (`<a>`)][html-a] or also link headers.

Alternatively HTTP link headers can also be handled with [`Expect Header` statement](./header).
:::

[html-a]: https://developer.mozilla.org/docs/Web/HTML/Element/a
[hal]: http://stateless.co/hal_specification.html

## Syntax

* Link steps are valid where representation is the context.
* Link steps are valid on top level.

## Usage

### Top-level link

Link block can be placed at the top of a test scenario document. This way it such a
link will be followed from any resource where it is found.

<<< @/api-examples/core/link/top-level.api

### Resource-specific links

Links can be used anywhere that resource representation is the block context. For example,
in [`Class block`](./class.md) or [`Property block`](./property.md).

<<< @/api-examples/core/link/nested.api

### Strict check

The example above can be modified to require that the presence of a link.

<<< @/api-examples/core/link/nested-mandatory.api

### Usage without children

A strict `Expect Link` can also be a statement, thus only checking that the link exists,
without performing any specific child checks.

<<< @/api-examples/core/link/statement.api

:::tip
The will should be dereferenced regardless and any applicable top-level steps
will be performed.
:::
