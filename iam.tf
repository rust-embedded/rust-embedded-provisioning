# Policies
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

# Users
resource "aws_iam_user" "nastevens" {
  name = "nastevens"
}

resource "aws_iam_user" "ryankurte" {
  name = "ryankurte"
}

# Groups and group membership
resource "aws_iam_group" "administrators" {
  name = "Administrators"
}

resource "aws_iam_group_policy_attachment" "administrators_admin" {
  group = "${aws_iam_group.administrators.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "administrators_change_pw" {
  group = "${aws_iam_group.administrators.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_group_membership" "administrators_membership" {
  name = "AdministratorsMembership"
  users = [
    "${aws_iam_user.nastevens.name}"
    "${aws_iam_user.ryankurte.name}"
  ]
  group = "${aws_iam_group.administrators.name}"
}
