# uat.hcl
#
# This file contains environment specific variables.
# Contents of this file becomes merged into the inputs for any of the Terragrunt
#   deployments found under this directory. This behavior can be changed with the root
#   terragrunt.hcl file (/Live/terragrunt.hcl)
#

locals {
  location    = "Central US"
  environment = "uat"

  # Common tags across all child resources for UAT environment
  tags = {
    "Requester" : "Jin Lee",
    "Organization" : "MS CSU",
    "Cost Center" : "999999",
    "ForProduction" : "false"
    "Environment": local.environment
  }
}
