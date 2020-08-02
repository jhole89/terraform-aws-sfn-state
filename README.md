# terraform-aws-sfn-state
[![Local Verify](https://github.com/jhole89/terraform-kubernetes-portainer/workflows/Verify/badge.svg?branch=master)](https://github.com/jhole89/terraform-aws-sfn-state/actions?query=workflow%3AVerify)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Terraform module for defining AWS Step Functions in pure terraform

[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40JoelLutman)](https://twitter.com/joellutman)

## Important note :warning:

This module is currently pre-release

## Features

Supported AWS Step Functions State:

| SF state | Implemented |
| --- | --- |
| [CHOICE](https://states-language.net/spec.html#choice-state) | :heavy_check_mark: |
| [FAIL](https://states-language.net/spec.html#fail-state) | :heavy_check_mark: |
| [MAP](https://states-language.net/spec.html#map-state) | :heavy_check_mark: |
| [PARALLEL](https://states-language.net/spec.html#parallel-state) | :heavy_check_mark: |
| [PASS](https://states-language.net/spec.html#pass-state) | :heavy_check_mark: |
| [SUCCEED](https://states-language.net/spec.html#succeed-state) | :heavy_check_mark: |
| [TASK](https://states-language.net/spec.html#task-state) | :heavy_check_mark: |
| [WAIT](https://states-language.net/spec.html#wait-state) | :heavy_check_mark: |

The module will create the following resources:

## Usage example

For a complete example, see [examples/hello-world](examples/hello-world/main.tf) which recreates the AWS Step Functions
HelloWorld template.

```hcl

```

**IMPORTANT:** The `master` branch is used in `examples` just as an example. Do not pin to `master` because there may 
be breaking changes between releases. Instead, pin to the release tag (e.g. `?ref=tags/x.y.z`) from 
[latest releases](https://github.com/jhole89/terraform-aws-sfn-state/releases).

<!--- BEGIN_TF_DOCS ---> 
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13.0 |
| local | ~> 1.2 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| comment | n/a | `string` | `null` | no |
| start\_at | n/a | `string` | `null` | no |
| states | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| json | JSON encoded state definition for use with other terraform resources |
| raw | n/a |

<!--- END_TF_DOCS --->

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/jhole89/terraform-aws-sfn-state/issues/new) section.

Full contributing [guidelines are covered here](https://github.com/jhole89/terraform-aws-sfn-state/blob/master/.github/CONTRIBUTING.md).

## Authors

Created by [Joel Lutman](https://github.com/jhole89) - [joel.lutman@gmail.com](mailto:joel.lutman@gmail.com)

## License

This module is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Share the Love 

Like this project? Please give it a ★ on [GitHub](https://github.com/jhole89/terraform-aws-sfn-state)! (it helps **a lot**)
