output "vpc_id" {
  value = aws_vpc.main.id
}

output "local_az_map" {
  value = local.az_map
}

# + locals_maps = {
#       + us-east-2a = 0
#       + us-east-2b = 1
#     }

output "public_subnet_ids" {
  value = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "private_subnet_ids" {
  value = { for az, subnet in aws_subnet.private : az => subnet.id }
}

# private_subnet_ids = {
#   "us-east-2a" = "subnet-02c74xxx"
#   "us-east-2b" = "subnet-07611xxx"
# }
