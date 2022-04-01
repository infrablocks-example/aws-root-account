locals {
  users = [
    for user in var.users :
    {
      name = user.name,
      password_length = user.password_length,
      public_gpg_key = filebase64(user.public_gpg_key_path),
      enforce_mfa = user.enforce_mfa,
      include_login_profile = user.include_login_profile,
      include_access_key = user.include_access_key,
      enabled = user.enabled
    }
  ]
}

module "access_control" {
  source  = "infrablocks/access-control/aws"
  version = "1.0.0"

  users = local.users
  groups = var.groups
}
