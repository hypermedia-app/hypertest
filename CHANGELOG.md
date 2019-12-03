# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [0.6.1](https://github.com/hypermedia-app/hypertest/compare/v0.6.1-0...v0.6.1) (2019-12-03)


### Bug Fixes

* change the output names to be easily distinguishable ([695219b](https://github.com/hypermedia-app/hypertest/commit/695219b))


### Features

* entrypoint statement to change the first request ([ca6c40e](https://github.com/hypermedia-app/hypertest/commit/ca6c40e))



### [0.6.1-0](https://github.com/hypermedia-app/hypertest/compare/v0.6.0...v0.6.1-0) (2019-11-13)


### Bug Fixes

* enforce UTF-8 encoding ([3ef7d23](https://github.com/hypermedia-app/hypertest/commit/3ef7d23))


### Tests

* generating with non plain ascii characters ([eb76adc](https://github.com/hypermedia-app/hypertest/commit/eb76adc))



## [0.6.0](https://github.com/hypermedia-app/hypertest/compare/v0.5.0...v0.6.0) (2019-10-10)


### Features

* added expect id step ([1618fad](https://github.com/hypermedia-app/hypertest/commit/1618fad)), closes [#59](https://github.com/hypermedia-app/hypertest/issues/59)



## [0.5.0](https://github.com/hypermedia-app/hypertest/compare/v0.4.0...v0.5.0) (2019-08-20)


### Bug Fixes

* allow hyphen in prefixed names ([cbb7797](https://github.com/hypermedia-app/hypertest/commit/cbb7797)), closes [#52](https://github.com/hypermedia-app/hypertest/issues/52)
* validate unmapped prefixes ([d01b516](https://github.com/hypermedia-app/hypertest/commit/d01b516)), closes [#49](https://github.com/hypermedia-app/hypertest/issues/49)


### Features

* gated blocks ([d9a0881](https://github.com/hypermedia-app/hypertest/commit/d9a0881))


### Tests

* check that gated works with prefixed names ([63d4f25](https://github.com/hypermedia-app/hypertest/commit/63d4f25))



## [0.4.0](https://github.com/hypermedia-app/hypertest/compare/v0.3.0...v0.4.0) (2019-07-28)


### Bug Fixes

* hydra identifiers must be URIs ([6966deb](https://github.com/hypermedia-app/hypertest/commit/6966deb))
* update xtext in cli ([81afff5](https://github.com/hypermedia-app/hypertest/commit/81afff5))
* **web:** preselect Core language in `<select>` ([63cf1c1](https://github.com/hypermedia-app/hypertest/commit/63cf1c1))


### Build System

* add editorconfig maven plugin ([e526c26](https://github.com/hypermedia-app/hypertest/commit/e526c26))


### Features

* **core-dsl:** extend property statement with other data types ([db1a72a](https://github.com/hypermedia-app/hypertest/commit/db1a72a)), closes [#50](https://github.com/hypermedia-app/hypertest/issues/50)
* **hydra-dsl:** explicit rdf:type expectation statement ([7cb2311](https://github.com/hypermedia-app/hypertest/commit/7cb2311)), closes [#50](https://github.com/hypermedia-app/hypertest/issues/50)
* allow expect operation without children ([16d2d0d](https://github.com/hypermedia-app/hypertest/commit/16d2d0d))
* check that URIs are valid ([b9dd73e](https://github.com/hypermedia-app/hypertest/commit/b9dd73e))
* generator reassembles prefixed names into URIs ([be056e9](https://github.com/hypermedia-app/hypertest/commit/be056e9))
* setting up request messages ([a9be8fd](https://github.com/hypermedia-app/hypertest/commit/a9be8fd)), closes [#32](https://github.com/hypermedia-app/hypertest/issues/32) [#42](https://github.com/hypermedia-app/hypertest/issues/42)
* warn if prefix does not seem right ([e498882](https://github.com/hypermedia-app/hypertest/commit/e498882))
* **hydra-dsl:** add prefixed names to hydra ([1e660d4](https://github.com/hypermedia-app/hypertest/commit/1e660d4))


### Tests

* prefixed name can be more than just letters ([a2f1181](https://github.com/hypermedia-app/hypertest/commit/a2f1181))



## [0.3.0](https://github.com/hypermedia-app/hypertest/compare/v0.2.1...v0.3.0) (2019-07-17)


### Features

* **dsl-core:** simple follow step ([b171bfa](https://github.com/hypermedia-app/hypertest/commit/b171bfa))



### [0.2.1](https://github.com/hypermedia-app/hypertest/compare/v0.2.0...v0.2.1) (2019-07-15)


### Build System

* add a deployment npm script ([d4c2a15](https://github.com/hypermedia-app/hypertest/commit/d4c2a15))



## [0.2.0](https://github.com/hypermedia-app/hypertest/compare/v0.1.0...v0.2.0) (2019-07-15)


### Bug Fixes

* cli displays line numbers when parsing fails ([53bff23](https://github.com/hypermedia-app/hypertest/commit/53bff23))
* terminal prevents expect and with from being keywords ([4eb1279](https://github.com/hypermedia-app/hypertest/commit/4eb1279))


### Build System

* **deps:** bump lodash.template from 4.4.0 to 4.5.0 ([efad79d](https://github.com/hypermedia-app/hypertest/commit/efad79d))


### Features

* generate JSON for header steps ([801575e](https://github.com/hypermedia-app/hypertest/commit/801575e))
* generator descends into subdirectories ([b49ea54](https://github.com/hypermedia-app/hypertest/commit/b49ea54))
* **dsl:** support expect property statement ([1362bce](https://github.com/hypermedia-app/hypertest/commit/1362bce))
* **dsl:** support for strict property value assertion ([2247bc4](https://github.com/hypermedia-app/hypertest/commit/2247bc4))
* **dsl-core:** add expect status step ([2a0838b](https://github.com/hypermedia-app/hypertest/commit/2a0838b))
* **dsl-core:** header statement ([a118906](https://github.com/hypermedia-app/hypertest/commit/a118906))
* **dsl-core:** link step ([7c615bf](https://github.com/hypermedia-app/hypertest/commit/7c615bf))
* **dsl-hydra:** add invoke block to operation ([4057069](https://github.com/hypermedia-app/hypertest/commit/4057069))
* **dsl-hydra:** add support for operations as child steps ([1d90e2e](https://github.com/hypermedia-app/hypertest/commit/1d90e2e))
* **dsl-hydra:** stub out hydra subgrammar ([8f14d16](https://github.com/hypermedia-app/hypertest/commit/8f14d16))
* **web:** add hydra to web editor ([908511c](https://github.com/hypermedia-app/hypertest/commit/908511c))
* add hydra support to cli compiler ([48d16ec](https://github.com/hypermedia-app/hypertest/commit/48d16ec))


### Tests

* bump jupiter to fix maven test ([f31f151](https://github.com/hypermedia-app/hypertest/commit/f31f151))
* parsing headers ([09523ad](https://github.com/hypermedia-app/hypertest/commit/09523ad))
* parsing link steps ([c970a02](https://github.com/hypermedia-app/hypertest/commit/c970a02))
* testing the variable reference converter ([e18d461](https://github.com/hypermedia-app/hypertest/commit/e18d461))
* **dsl-core:** generating JSON for links ([1d69d73](https://github.com/hypermedia-app/hypertest/commit/1d69d73))
* **generator:** added first snapshot test of with class ([4f0842f](https://github.com/hypermedia-app/hypertest/commit/4f0842f))



## 0.1.0 (2019-07-07)


### Build System

* add CLI project to parent POM ([e8ff119](https://github.com/hypermedia-app/hypertest/commit/e8ff119))
* make the jar executable ([23c397f](https://github.com/hypermedia-app/hypertest/commit/23c397f))
* set up commit linting ([a1a8604](https://github.com/hypermedia-app/hypertest/commit/a1a8604))


### Features

* compile entire directory in-place ([a14d5cc](https://github.com/hypermedia-app/hypertest/commit/a14d5cc))
* jdeploy setup ([b723504](https://github.com/hypermedia-app/hypertest/commit/b723504))
