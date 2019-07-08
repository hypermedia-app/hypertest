# How it works

## Test runner algorithm

A runner implementation should implement a simple algorithm to advance the test client through
an API.

### 1. Request the staring resource

The first step is to perform a server request to `GET` the first resource representation.
Typically that would be a well known API entrypoint or home but more specific test scenarios
could require a more specific staring point to execute the tests.

### 2. Select applicable top-level scenario steps

The runner then walks the top-level scenario blocks in order in which they appear in the test
document. Any one scenario which applies to the given representation is processed, depth-first
by stepping into the child steps. 

### 3. Process scenario steps

Every step is checked against the response to verify correctness. If the the check
passes and the step has any children those children are processed first before advancing to
the next statement on the same level.

:::tip
There is no explicit `break` condition. When a check fails its children are skipped but the
subsequent steps must be processed.
:::

### Analysing additional representations

Certain blocks may change the representation being analysed (such as by following a `Link`,
submitting a form, or simply visiting an embedded resource). In such case the test runner should
first proceed with the nested steps and then go to step 2 to process any applicable top-level
step. 

### Note on processing steps multiple times

Individual steps can have their own specific rules on what happens when they are visited
multiple time during test execution. Some may allow adjusting this behavior to achieve various
results.

For example most `Expect` steps will be processed every time they are visited.

Do consult the documentation of each step for details.

## Complete example

Here's a but more complex example which visits multiple linked resources.

:::warning
The snippet below presents features not yet implemented by the DSL. Its details are subject to
change but the general processing rules will remain largely the same.
:::

### Resources

Let's consider an API which holds resources representing a personal profiles. The root resource
should link to the said profile, which further links to person's interests.

:::tip
Note that the representations are not structured using any specific media type. A concrete test 
runner has to be implemented to "understand" how to extract the hypermedia controls from the
target format.
:::

```json
{
    "id": "/",
    "_links": [
      {
        "rel": "profile",
        "href": "/profile/tomasz"
      }
    ] 
}
```

```json
{
  "id": "/profile/tomasz",
  "type": "Profile",
  "firstName": "Tomasz",
  "lastName": "Pluskiewicz",
  "_links": [
    {
      "rel": "interest",
      "href": [
        "/profile/tomasz/interest/rest-apis",
        "/profile/tomasz/interest/web-components"
      ]
    }
  ]
}
```

Here's the representation of one of the interests.

```json
{
  "id": "/profile/tomasz/interest/rest-apis",
  "title": "RESTful APIs",
  "_links": [
    {
      "rel": "related",
      "href": "https://restfulapi.net"
    }
  ]
}
```

For the sake of the example let's assume that the other interest resource returns
`404`.

### Test document

```
With Class "Profile" {
    Expect Property "firstName"
    Expect Property "lastName"
    
    Follow Link "interest" {
        Expect Status 200
    }
}

With Class "Interest" {
    Expect Property "title"
    Expect Property "since"

    With Link "related" {
        Expect Status 200
    }
}

With Link "profile" {
    Expect Status 200
}
```

### Processing result

1. Request the root `/` resource
    1. Check that status code is `200` :white_check_mark:
    1. Process `With Link "profile"` as the link exists
1. Request `/profile/tomasz`
    1. Process `With Class "Profile"`
    1. Check that property `firstName` exists :white_check_mark:
    1. Check that property `lastName` exists ❌
    1. `Follow Link "interest"` (both linked resources)
1. Request `/profile/tomasz/interest/rest-apis`
    1. Check status code :white_check_mark:
    1. Check that property `title` exists :white_check_mark:
    1. Check that property `since` exists ❌
    1. Link `related` exists :white_check_mark: 
        1. Process `With Link "related"`
1. Request `https://restfulapi.net`
    1. Check status code :white_check_mark:
1. Request `/profile/tomasz/interest/web-components`
    1. Got status code `404` but `200` was expected ❌
