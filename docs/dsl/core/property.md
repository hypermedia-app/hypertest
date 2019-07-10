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

```
Expect Property "name"
```

### Asserting literal property value

An optional parameter can be provided, which instructs the client to compare it with 
the actual value of the property.

```
Expect Property "name" "Tomasz"
```

:::warning
At the time of writing only string is allowed. The test runner should always compare
textual form of non-string values.
:::

### Step into nested resource

A property step can also be a block.

If a property is not necessary for the success of the test scenario, it may be treated as 
optional, by using `With` modifier instead of `Expect` modifier.

```
With Class "Book" {
    
    # Book may have an embedded author resource
    # Use Expect Property if author is manadatory
    With Property "author" {
    
        # If it does't check that it has a name
        Expect Property "name"
    }
}
```
