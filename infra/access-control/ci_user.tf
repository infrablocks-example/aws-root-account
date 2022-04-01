locals {
  ci_user = {
    access_key_id = module.user.user_access_key_id
    arn =  module.user.user_arn
    name =  module.user.user_name
    secret_access_key =  module.user.user_secret_access_key
  }
}

module "user" {
  source  = "infrablocks/user/aws"
  version = "0.3.0-rc.2"

  user_name = "ci"
  enforce_mfa = "no"
  include_access_key = "yes"
  include_login_profile = "no"
  user_public_gpg_key = filebase64(var.ci_user_public_gpg_key_path)
}

data "aws_iam_policy_document" "assume_any_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "assume_any_role_policy" {
  name = "AssumeAnyRolePolicy"
  user = module.user.user_name
  policy = data.aws_iam_policy_document.assume_any_role_policy_document.json
}
