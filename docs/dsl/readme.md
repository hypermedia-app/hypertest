# Hypertest DSL

A [domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language), in which
API authors and testers test client-server interactions by focusing on the API's [hypermedia
controls](https://en.wikipedia.org/wiki/HATEOAS), that is links and forms.

A distinguishing feature is that within a Hypertest DSL document there will not be a single
mention of individual resource identifiers. The idea is that an entry URL is given as test runner
input and the test scenarios are executed by performing requests only as allowed by the hypermedia
controls of individual resource representations.

## Basics

Hypertest DSL documents are plain text files. Multiple file extensions can be used
depending on the targeting media type.

The DSL is case-sensitive, including its keywords.

## Document structure

A test document can have one or more [top-level steps](/dsl/steps/#top-level). Every such step
begins with the `With` keyword, followed by the type name, type-specific parameters, and brackets
which enclose optional settings and child steps.

Child step follow a similar pattern but with more relaxed syntax rules. Typically they
will be structured similarly, as `Modifiers Type Parameters {}`. Individual types of those steps
define the allowed modifiers and parameters. The children may also be optional in some cases.  

### Example

```
// Type: Class
// Parameters: "Person"
With Class "Person" {
    // Optional settings and child blocks go here
    
    // For example, `Expect Property` statement does not require a body 
    Expect Property "name"
}

/*
    Multiline comments are also supported
*/
```
