[![conventional commits](https://img.shields.io/badge/conventional%20commits-1.0.0-yellow.svg)](https://conventionalcommits.org) [![semantic versioning](https://img.shields.io/badge/semantic%20versioning-2.0.0-green.svg)](https://semver.org)

## [1.3.0](https://github.com/wearefrank/haalcentraal-connector/compare/v1.2.0...v1.3.0) (2024-08-12)

### 🍕 Features

* BRP zoek personen ([616cdf4](https://github.com/wearefrank/haalcentraal-connector/commit/616cdf477b594a289e9a7e231e2224e6f84287b5))

## [1.2.0](https://github.com/wearefrank/haalcentraal-connector/compare/v1.1.0...v1.2.0) (2024-08-08)

### 🍕 Features

* add Oauth ([559360b](https://github.com/wearefrank/haalcentraal-connector/commit/559360bb4223d2d17342e3bcbb105978490e475c))

## [1.1.0](https://github.com/wearefrank/haalcentraal-connector/compare/v1.0.0...v1.1.0) (2024-08-08)

### 🍕 Features

* add Bv03 response wrapper ([cd83bda](https://github.com/wearefrank/haalcentraal-connector/commit/cd83bda04215394f1846509db956863acfa9de04))
* add credentialfactory to docker file ([3af7af0](https://github.com/wearefrank/haalcentraal-connector/commit/3af7af0bae611cc65e6eb80303ee177edbd6a622))
* add database check ([60158a4](https://github.com/wearefrank/haalcentraal-connector/commit/60158a43e04b3d76e5d9caada4eb901f868c6eb4))
* add errorStore with scheduler (workaround) ([6685edd](https://github.com/wearefrank/haalcentraal-connector/commit/6685eddd04ddd54cc7933eba85a5ace2eceb354e))
* add mapping for BRP API Personen ([6a0a156](https://github.com/wearefrank/haalcentraal-connector/commit/6a0a15636938185c1f7b713baf986682045b8d7e))
* add postgress connection through docker ([29c3048](https://github.com/wearefrank/haalcentraal-connector/commit/29c3048507dec53eda8b254f8d21e189c00e5eb6))
* Add retry param ([767721f](https://github.com/wearefrank/haalcentraal-connector/commit/767721f863bd28b4ead696322903f21308baccf8))
* first working version of adapters with end-to-end connectivity ([e26d54e](https://github.com/wearefrank/haalcentraal-connector/commit/e26d54e933e465e421e37abd4433e4835dcbc463))
* main flow implementation ([f6600af](https://github.com/wearefrank/haalcentraal-connector/commit/f6600af74e5d34d761d9031a85198f4e952fa39a))
* split up flow to add afnemersindicatie flow ([1d5c560](https://github.com/wearefrank/haalcentraal-connector/commit/1d5c5607c0632f36ea5c54bdd1c25775bd844d53))
* working logic subscription, base structure ([1db1435](https://github.com/wearefrank/haalcentraal-connector/commit/1db1435142b9b3c2e9e9064b8a804aead4c52ce4))

### 🐛 Bug Fixes

* instance.name in DeploymentSpecific.properties ([c96fe46](https://github.com/wearefrank/haalcentraal-connector/commit/c96fe46d7b4b5726ffbaba193b430b3126eba8a8))

### 🧑‍💻 Code Refactoring

* change configurations names docker ([db426e5](https://github.com/wearefrank/haalcentraal-connector/commit/db426e52a88cdcf8d38cb2faca0c163d228ae1c2))
* change param X-API-KEY ([5e3da02](https://github.com/wearefrank/haalcentraal-connector/commit/5e3da02027a7b9607234a2807fa5c31506667418))
* change pw credentials ([083900b](https://github.com/wearefrank/haalcentraal-connector/commit/083900b799eeb29823b5c875df453e1976357760))
* change to name appid ([97aa2fa](https://github.com/wearefrank/haalcentraal-connector/commit/97aa2fafa9b32805fe47267613d8e26ef555d671))
* create one configuration for post request ([74b19dc](https://github.com/wearefrank/haalcentraal-connector/commit/74b19dc11395181fc2b88d111afca708e116c60f))
* fix small bugs ([c4ba240](https://github.com/wearefrank/haalcentraal-connector/commit/c4ba240ad1838396acf00014177d569994c0a734))
* merge endpoints to one place ([e2fe02d](https://github.com/wearefrank/haalcentraal-connector/commit/e2fe02dcf107c2bdbffb5e377f2c791aa50ba6a2))
* remove datasourcename ([efba1cb](https://github.com/wearefrank/haalcentraal-connector/commit/efba1cb70e7eae8baa51f8887f7a47574fbf4527))
* small change ([7b636c2](https://github.com/wearefrank/haalcentraal-connector/commit/7b636c286948755758c7d0d2004eeeb3629eaaf5))
* small mistake :9 ([0040b53](https://github.com/wearefrank/haalcentraal-connector/commit/0040b53048051601257c6de67eb43347807d9a56))
* typo ([eb8e6a6](https://github.com/wearefrank/haalcentraal-connector/commit/eb8e6a6612616c1d17e9c7e058fd00c866b75b1f))
* typo ([827bb2a](https://github.com/wearefrank/haalcentraal-connector/commit/827bb2a31c8d729207fe57aa1b770c1860cc89ce))
* X-API-KEY ([f39f06a](https://github.com/wearefrank/haalcentraal-connector/commit/f39f06af03570505236813595cdd39689f08924e))

### ✅ Tests

* add initial tests enviroment ([66c4fdb](https://github.com/wearefrank/haalcentraal-connector/commit/66c4fdb6c9e2b2b650ff3a6e359b2ae54ec2cedf))

### 🔁 Continuous Integration

* remove locked sementic release version ([60cbb8a](https://github.com/wearefrank/haalcentraal-connector/commit/60cbb8aad2afda2f4b2a4fe7ab0e903c82e4b821))

## 1.0.0 (2024-05-30)


### 🐛 Bug Fixes

* instance.name in DeploymentSpecific.properties ([#2](https://github.com/wearefrank/haalcentraal-connector/issues/2)) ([2269828](https://github.com/wearefrank/haalcentraal-connector/commit/22698284babd58f40a9e690d1c39b3d368e7f963))


### 🔁 Continuous Integration

* apply fix from skeleton repository ([#1](https://github.com/wearefrank/haalcentraal-connector/issues/1)) ([621a7e2](https://github.com/wearefrank/haalcentraal-connector/commit/621a7e2555f191e069965903b9374456a470a976))
* update workflows ([45d22fe](https://github.com/wearefrank/haalcentraal-connector/commit/45d22fee7f54753ef50a843f2bf8ea77c4f1268f))
