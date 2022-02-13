# AWS Organization Terraform module

---

![CI](https://github.com/zeroconfigio/terraform-aws-organization/workflows/CI/badge.svg?branch=main)
![Documentation](https://github.com/zeroconfigio/terraform-aws-organization/workflows/Docs/badge.svg?branch=main)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Description

Terraform module which sets up AWS Organization in the root account.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.ous](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization_accounts"></a> [organization\_accounts](#input\_organization\_accounts) | Map of organization accounts to create. The map key is the name of the account and the value is an object containing account configuration variables. | `any` | n/a | yes |
| <a name="input_organization_aws_service_access_principals"></a> [organization\_aws\_service\_access\_principals](#input\_organization\_aws\_service\_access\_principals) | n/a | `list` | <pre>[<br>  "aws-artifact-account-sync.amazonaws.com",<br>  "cloudtrail.amazonaws.com",<br>  "securityhub.amazonaws.com",<br>  "guardduty.amazonaws.com",<br>  "config.amazonaws.com",<br>  "fms.amazonaws.com",<br>  "sso.amazonaws.com"<br>]</pre> | no |
| <a name="input_organization_enabled_policy_types"></a> [organization\_enabled\_policy\_types](#input\_organization\_enabled\_policy\_types) | List of Organizations policy types to enable in the Organization Root. Organization must have feature\_set set to ALL. For additional information about valid policy types (e.g. AISERVICES\_OPT\_OUT\_POLICY, BACKUP\_POLICY, SERVICE\_CONTROL\_POLICY, and TAG\_POLICY | `list(string)` | <pre>[<br>  "SERVICE_CONTROL_POLICY"<br>]</pre> | no |
| <a name="input_organization_feature_set"></a> [organization\_feature\_set](#input\_organization\_feature\_set) | Specify ALL or CONSOLIDATED\_BILLING | `string` | `"ALL"` | no |
| <a name="input_organization_units"></a> [organization\_units](#input\_organization\_units) | Create flat organization units | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization"></a> [organization](#output\_organization) | AWS organization attributes |
| <a name="output_organization_all_accounts"></a> [organization\_all\_accounts](#output\_organization\_all\_accounts) | Map of the organization units attributes where key is account name |
| <a name="output_organization_all_organizational_units"></a> [organization\_all\_organizational\_units](#output\_organization\_all\_organizational\_units) | Map of the organization units attributes where key is ou name |
| <a name="output_organization_master_account_id"></a> [organization\_master\_account\_id](#output\_organization\_master\_account\_id) | Management account id |

<!--- END_TF_DOCS --->

## Usage

```
module "organization" {
  source = "git::https://github.com/zeroconfigio/terraform-aws-organization.git"

  organization_accounts = {
    security = {
      email       = "aws+security@example.com",
      parent_name = "sec",
      tags        = {
        "provisioned" = "terraform"
        "account"     = "security"
      }
    },
    stage = {
      email     = "aws+development@example.com",
      parent_id = "dev",
      tags        = {
        "provisioned" = "terraform"
        "account"     = "stage"
      }
    },
    production = {
      email     = "aws+production@example.com",
      parent_id = "prod",
      tags        = {
        "provisioned" = "terraform"
        "account"     = "production"
      }
    },
  }

  organization_units = [
    "security",
    "stage",
    "production"
  ]

  organization_aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "securityhub.amazonaws.com",
    "guardduty.amazonaws.com",
    "config.amazonaws.com",
    "fms.amazonaws.com",
    "sso.amazonaws.com"
  ]
}
```

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/zeroconfigio/terraform-aws-organization/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or help out with our other projects, we would love to hear from you! Send us an email.

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

#### Dev Dependencies

##### Pre-Commit

###### Installation

Before you can run hooks, you need to have the [pre-commit](https://pre-commit.com/) package manager installed.

Using pip:

```
pip install pre-commit
```

In a python project, add the following to your requirements.txt (or requirements-dev.txt):

```
pre-commit
```

Using homebrew:

```
brew install pre-commit
```

###### Install the git hook scripts

Run pre-commit install to set up the git hook scripts

```
$ pre-commit install
pre-commit installed at .git/hooks/pre-commit
```

now `pre-commit` will run automatically on `git commit`!

###### (optional) Run against all the files

it's usually a good idea to run the hooks against all of the files when adding new hooks (usually pre-commit will only run on the changed files during git hooks)

```
$ pre-commit run -a
```

## Copyrights

Copyright © 2021-2022 [ZeroConfig.io](https://zeroconfig.io)


## License

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

See [LICENSE](LICENSE) for full details.

## Trademarks
All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [ZeroConfig.io](https://zeroconfig.io).

Author [igor.js](https://github.com/igorjs)
