
data "aws_caller_identity" "current" {}

# Policy template
data "aws_iam_policy_document" "role_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

# TODO: add policies for admins to manage their own mfa and enable after testing
#    condition {
#      test     = "Bool"
#      variable = "aws:MultiFactorAuthPresent"
#      values   = ["true"]
#    }
  }
}

# Base Policies
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length = 16
  require_lowercase_characters = true
  require_uppercase_characters = true
  require_numbers = true
  require_symbols = true
  allow_users_to_change_password = true
  hard_expiry = false
  max_password_age = 90
}

# Create users
resource "aws_iam_user" "nastevens" {
  name = "nastevens"
}

resource "aws_iam_user" "ryankurte" {
  name = "ryankurte"
}


# Create adminstrator group
resource "aws_iam_group" "administrators" {
  name = "Administrators"
}

# Policy document for assume_role_admin
data "aws_iam_policy_document" "assume_role_admin" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["${aws_iam_role.administrators.arn}"]
  }
}

# Actual policy for assume_role_admin
resource "aws_iam_policy" "assume_role_admin" {
  name        = "administrators-permit-assume-role"
  description = "Allow administrators to assume admin role"
  policy      = "${data.aws_iam_policy_document.assume_role_admin.json}"
}

# Create administrators role with assume-admin policy
resource "aws_iam_role" "administrators" {
  name               = "assume-admin"
  assume_role_policy = "${data.aws_iam_policy_document.role_trust.json}"
}

# Attach assume admin policy to administrators group
resource "aws_iam_group_policy_attachment" "assume_role_admin" {
  group      = "${aws_iam_group.administrators.name}"
  policy_arn = "${aws_iam_policy.assume_role_admin.arn}"
}

# Attach admin policy to administrators group
resource "aws_iam_group_policy_attachment" "administrators_admin" {
  group = "${aws_iam_group.administrators.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach pasword change policy to administrators group
resource "aws_iam_group_policy_attachment" "administrators_change_pw" {
  group = "${aws_iam_group.administrators.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

# Add members to group
resource "aws_iam_group_membership" "administrators_membership" {
  name = "AdministratorsMembership"
  users = [
    "${aws_iam_user.nastevens.name}",
    "${aws_iam_user.ryankurte.name}"
  ]
  group = "${aws_iam_group.administrators.name}"
}

