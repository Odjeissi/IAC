# AWS VPC

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.env}-vpc-main"
    Environment = var.env
  }

}


# AWS IGW

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.env}-igw-main"
    Environment = var.env
  }
}


# Fetch Available AZ

data "aws_availability_zones" "available" {
  state = "available"

  # fetch only Availability Zones (no Local Zones):
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# Limit the number of AZs to be used

locals {

  # Get a list of Availability Zones (AZs) to use.
  # Takes the first `var.numb_az` AZs from the region, but never exceeds the total number of AZs actually available.
  azs = slice(data.aws_availability_zones.available.names, 0, min(var.numb_az, length(data.aws_availability_zones.available.names)))

  # Create a map where each AZ name is the key and its position in the AZ list is the value.
  az_map = { for idx, az in local.azs : az => idx }
}

# AWS Public Subnet

resource "aws_subnet" "public" {
  for_each                = local.az_map
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.env}-public-${each.key}"
    Environment = var.env
  }
}


# AWS Private Subnet

resource "aws_subnet" "private" {
  for_each          = local.az_map
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + var.numb_az)
  availability_zone = each.key

  tags = {
    Name        = "${var.env}-private-${each.key}"
    Environment = var.env
  }
}

# AWS Public RT

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.env}-public-rt"
    Environment = var.env
  }
}

# AWS Public RT Association

resource "aws_route_table_association" "public_rt_association" {

  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# AWS Private RT

resource "aws_route_table" "private_rt" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[each.key].id
    }
  }

  tags = {
    Name        = "${var.env}-private-rt-${each.key}"
    Environment = var.env
  }
}

# AWS Private RT Association

resource "aws_route_table_association" "private_rt_association" {

  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt[each.key].id
}

# AWS EIP

resource "aws_eip" "this" {
  # Create a EIP for each public subnet when NAT Gateway is enabled
  for_each = var.enable_nat ? aws_subnet.public : {}

  domain = "vpc"

  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${var.env}-eip-${each.key}"
  }
}

# Wait 60 seconds after NAT resources are destroyed to allow
# AWS release associated EIPs
# preventing errors during destroy

resource "time_sleep" "wait_after_nat_destroy" {
  for_each = var.enable_nat ? aws_subnet.public : {}

  depends_on = [aws_eip.this]

  destroy_duration = "90s"
}

# AWS NAT

resource "aws_nat_gateway" "main" {
  # Create a NAT Gateway for each public subnet when NAT Gateway is enabled
  for_each = var.enable_nat ? aws_subnet.public : {}

  allocation_id = aws_eip.this[each.key].allocation_id

  # Put the NAT Gateway in each public subnet
  subnet_id = each.value.id

  depends_on = [aws_internet_gateway.main, time_sleep.wait_after_nat_destroy]

  tags = {
    Name        = "${var.env}-nat-${each.key}"
    Environment = var.env
  }
}
