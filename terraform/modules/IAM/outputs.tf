output "iam_role_arn" {
  value = aws_iam_role.iam_role_main.arn
}

output "iam_role_id" {
  value = aws_iam_role.iam_role_main.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.main.name
}
