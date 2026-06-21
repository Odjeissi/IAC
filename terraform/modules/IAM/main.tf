# AWS IAM role

resource "aws_iam_role" "iam_role_main" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = var.iam_role_config.Action
        Effect    = var.iam_role_config.Effect
        Sid       = var.iam_role_config.Sid
        Principal = var.iam_role_config.Principal
      },
    ]
  })

  tags = {
    Name        = "${var.env}-iam-role"
    Environment = var.env
  }
}


resource "aws_iam_role_policy" "iam_role_policy" {
  name = var.iam_role_policy_name
  role = aws_iam_role.iam_role_main.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.iam_role_policy_config.Action
        Effect   = var.iam_role_policy_config.Effect
        Resource = "${var.iam_role_policy_resource_arn}/*"
      },
    ]
  })
}


# AWS Instance Profile

resource "aws_iam_instance_profile" "main" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.iam_role_main.name
}
