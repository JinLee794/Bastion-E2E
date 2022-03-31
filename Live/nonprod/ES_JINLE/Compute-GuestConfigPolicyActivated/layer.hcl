locals {
  tags       = {}
  layer_name = "bastion-compute-guestconfigpolicy"

  admin_username             = "jleeadmin"
  admin_password_secret_name = "win-sandbox-admin"
  env                        = "sandbox"

  # VM specific
  BuildBastionInfra = true
}
