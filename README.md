# AWS Organization Terraform module

---

![Terraform validation](https://github.com/igorjs/terraform-aws-organization/workflows/Terraform%20validation/badge.svg?branch=main)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Description

Terraform module which sets up AWS Organization in the root account.

## Usage

```
module "organization" {
  source = "git::https://github.com/igorjs/terraform-aws-organization.git"

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

## Dev Dependencies

### Pre-Commit

#### Installation

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

Using conda (via conda-forge):

```
conda install -c conda-forge pre-commit
```

##### Install the git hook scripts

Run pre-commit install to set up the git hook scripts

```
$ pre-commit install
pre-commit installed at .git/hooks/pre-commit
```

now `pre-commit` will run automatically on `git commit`!

##### (optional) Run against all the files

it's usually a good idea to run the hooks against all of the files when adding new hooks (usually pre-commit will only run on the changed files during git hooks)

```
$ pre-commit run -a
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 2.0   |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 3.73.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                       | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_organizations_account.accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account)                    | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization)               | resource |
| [aws_organizations_organizational_unit.ous](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name                                                                                                                                                            | Description                                                                                                                                                                                                                                                      | Type           | Default                                                                                                                                                                                                                                       | Required |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_organization_accounts"></a> [organization_accounts](#input_organization_accounts)                                                                | Map of organization accounts to create. The map key is the name of the account and the value is an object containing account configuration variables.                                                                                                            | `any`          | n/a                                                                                                                                                                                                                                           |   yes    |
| <a name="input_organization_aws_service_access_principals"></a> [organization_aws_service_access_principals](#input_organization_aws_service_access_principals) | n/a                                                                                                                                                                                                                                                              | `list`         | <pre>[<br> "aws-artifact-account-sync.amazonaws.com",<br> "cloudtrail.amazonaws.com",<br> "securityhub.amazonaws.com",<br> "guardduty.amazonaws.com",<br> "config.amazonaws.com",<br> "fms.amazonaws.com",<br> "sso.amazonaws.com"<br>]</pre> |    no    |
| <a name="input_organization_enabled_policy_types"></a> [organization_enabled_policy_types](#input_organization_enabled_policy_types)                            | List of Organizations policy types to enable in the Organization Root. Organization must have feature_set set to ALL. For additional information about valid policy types (e.g. AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, and TAG_POLICY | `list(string)` | <pre>[<br> "SERVICE_CONTROL_POLICY"<br>]</pre>                                                                                                                                                                                                |    no    |
| <a name="input_organization_feature_set"></a> [organization_feature_set](#input_organization_feature_set)                                                       | Specify ALL or CONSOLIDATED_BILLING                                                                                                                                                                                                                              | `string`       | `"ALL"`                                                                                                                                                                                                                                       |    no    |
| <a name="input_organization_units"></a> [organization_units](#input_organization_units)                                                                         | Create flat organization units                                                                                                                                                                                                                                   | `list(string)` | <pre>[<br> "default"<br>]</pre>                                                                                                                                                                                                               |    no    |

## Outputs

| Name                                                                                                                                               | Description                                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| <a name="output_aws_organizations_account"></a> [aws_organizations_account](#output_aws_organizations_account)                                     | Map of the organization accounts attributes where key is account name |
| <a name="output_aws_organizations_organizational_unit"></a> [aws_organizations_organizational_unit](#output_aws_organizations_organizational_unit) | Map of the organization units attributes where key is ou name         |
| <a name="output_organization"></a> [organization](#output_organization)                                                                            | AWS organization attributes                                           |
| <a name="output_organization_all_accounts"></a> [organization_all_accounts](#output_organization_all_accounts)                                     | Map of the organization units attributes where key is account name    |
| <a name="output_organization_all_organizational_units"></a> [organization_all_organizational_units](#output_organization_all_organizational_units) | Map of the organization units attributes where key is ou name         |
| <a name="output_organization_master_account_id"></a> [organization_master_account_id](#output_organization_master_account_id)                      | Management account id                                                 |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

[MIT License](./LICENSE)

### Author

[igor.js](https://github.com/igorjs) on behalf of [ZeroConfig.io](https://github.com/zeroconfigio)
