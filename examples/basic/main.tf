locals {
  tags = {
    "provisioned" = "terraform"
  }
}

module "organization" {
  source = "git::https://github.com/igorjs/terraform-aws-organization.git"

  organization_accounts = {
    security = {
      email       = "aws+security@example.com",
      parent_name = "sec",
      tags        = local.tags
    },
    stage = {
      email     = "aws+development@example.com",
      parent_id = "dev",
      tags      = local.tags
    },
    production = {
      email     = "aws+production@example.com",
      parent_id = "prod",
      tags      = local.tags
    },
  }

  organization_units = [
    "security",
    "stage",
    "production"
  ]

  organization_aws_service_access_principals = [
    "aws-artifact-account-sync.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "securityhub.amazonaws.com",
    "guardduty.amazonaws.com",
    "config.amazonaws.com",
    "fms.amazonaws.com",
    "sso.amazonaws.com"
  ]
}
