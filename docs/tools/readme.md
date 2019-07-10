---
sidebar: auto
---

# Hypertest Tooling

## Hypertest compiler

An [Xtend](https://www.eclipse.org/xtend/) generator is available as an executable
JAR which compiles DSL documents into JSON. That JSON is then intended for processing
by test runners.

### Requirements

* Java 8

### Installation

```shell
npm i -g @hydrofoil/hypertest
```

:::tip
Node.js is used to distribute the CLI. Java doesn't have to be installed beforehand,
the node runner should install it if necessary 
:::

### Usage

The compiler takes a single parameter which is the directory containing test
scenarios:

```shell
hypertest-compiler ./tests
``` 

## Hydra test runner

:::warning
:construction: Work in progress :construction: 
:::

Once compiled, the tests can be executed against Hydra APIs using [`hydra-validator`](https://github.com/hypermedia-app/hydra-validator)

### Installation

```shell
npm i hydra-validator hydra-validator-e2e
```

### Usage

```
> hydra-validator e2e --help

Usage: e2e [options] <url>

Options:
  -d, --docs <docsPath>  path to JSON containing test scenarios
  -h, --help             output usage information
```
