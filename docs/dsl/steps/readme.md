# Steps

There two kinds of steps which constitute a test document:

* Statements
* Blocks

The only difference is that blocks have children. Some steps can appear both as a statement
and as a block.

## Syntax

The general EBNF syntax is roughly:

```
Step       = Block | Statement
Statement  = [ Prefix ] Name Parameters
Parameters = Parameter { Parameter }
Block      = Statement "{" { Step } "}"
Prefix     = ? Prefix string ?
Name       = ? One of valid step names ?
Parameter  = ? Step-specific string ?
```

## Top level steps

* [Class](./class)

## Child steps

* [Expect](./expect)
