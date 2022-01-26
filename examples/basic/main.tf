locals {
  tags = {
    "provisioned" = "terraform"
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

  organization_accounts = {
    security = {
      email       = "aws+security@igorjs.io",
      parent_name = "sec",
      tags        = local.tags
    },
    stage = {
      email     = "aws+development@igorjs.io",
      parent_id = "dev",
      tags      = local.tags
    },
    production = {
      email     = "aws+production@igorjs.io",
      parent_id = "prod",
      tags      = local.tags
    },
  }
}

module "organization" {
  source                = "../../"
  organization_accounts = local.organization_accounts
  organization_units    = local.organization_units
  organization_aws_service_access_principals = local.organization_aws_service_access_principals
}
