# AWS Organization Terraform module

---

![CI](https://github.com/zeroconfigio/terraform-aws-organization/workflows/CI/badge.svg?branch=main)
![Documentation](https://github.com/zeroconfigio/terraform-aws-organization/workflows/Docs/badge.svg?branch=main)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Description

Terraform module which sets up AWS Organization in the root account.

<!--- BEGIN_TF_DOCS --->
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
