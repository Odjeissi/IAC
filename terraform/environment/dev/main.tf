# AWS VPC

module "vpc_main" {
  source     = "../../modules/network/vpc"
  vpc_cidr   = var.vpc_cidr
  env        = var.env
  enable_nat = var.enable_nat
  numb_az    = var.numb_az
}

# AWS SG

module "SGs_main" {
  source               = "../../modules/network/security_groups"
  vpc_id               = module.vpc_main.vpc_id
  env                  = var.env
  ec2_ingress          = var.ec2_ingress
  db_ingress           = var.db_ingress
  db_cidr_ipv4_ingress = var.vpc_cidr
  lb_ingress           = var.lb_ingress
}

# AWS LB

module "lb_main" {
  source              = "../../modules/lb"
  env                 = var.env
  load_balancer_type  = var.load_balancer_type
  security_groups     = [module.SGs_main.allow_lb_traffic_id]
  subnets             = [for subnet_ids in module.vpc_main.public_subnet_ids : subnet_ids]
  target_type         = var.target_type
  vpc_id              = module.vpc_main.vpc_id
  acm_certificate_Arn = module.acm_main.acm_certificate_arn
}

# AWS Key deployer

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.PUB_KEY)
}

# AWS Launch Template

module "launch_template_main" {
  source                 = "../../modules/launch_template"
  env                    = var.env
  instance_type_template = var.instance_type_template
  key_name               = aws_key_pair.deployer.key_name
  user_data              = filebase64(var.user_data)
  sg_ids                 = [module.SGs_main.allow_ec2_traffic_id]
  instance_profile_name  = module.iam_role_main.instance_profile_name
}

# AWS Auto Scaling Group

module "auto_scaling_group_main" {
  source                    = "../../modules/auto_scaling"
  env                       = var.env
  autoScaling_configuration = var.autoScaling_configuration
  launch_template_id        = module.launch_template_main.instances_template_id
  template_lasted_version   = module.launch_template_main.instances_template_latest_version
  tg_arn                    = [module.lb_main.target_group_arn]
  subnet_ids                = [for subnet_ids in module.vpc_main.public_subnet_ids : subnet_ids]
}


# AWS s3

module "s3_main" {
  source         = "../../modules/s3"
  env            = var.env
  s3_bucket_name = var.s3_bucket_name
}


# AWS IAM role

module "iam_role_main" {
  source                       = "../../modules/IAM"
  iam_role_name                = var.iam_role_name
  iam_role_config              = var.iam_role_config
  env                          = var.env
  iam_role_policy_name         = var.iam_role_policy_name
  iam_role_policy_config       = var.iam_role_policy_config
  iam_role_policy_resource_arn = module.s3_main.s3_main_arn
  iam_instance_profile_name    = var.iam_instance_profile_name
}

# AWS Route53

module "route53_main" {
  source              = "../../modules/route53"
  domain_name         = var.domain_name
  route53_record_name = var.route53_record_name
  route53_record_type = var.route53_record_type
  route53_record_alias = {
    name                   = module.lb_main.lb_dns_name
    zone_id                = module.lb_main.lb_zone_id
    evaluate_target_health = true
  }
}

# AWS ACM

module "acm_main" {
  source      = "../../modules/acm"
  domain_name = var.domain_name
}

# AWS DB

module "db_main" {
  source           = "../../modules/rds"
  env              = var.env
  db_configuration = var.db_configuration
  sg_ids_db        = [module.SGs_main.allow_db_traffic_id]
  db_username      = var.db_username
  db_password      = var.db_password
  db_subnet_ids    = [for subnet_ids in module.vpc_main.private_subnet_ids : subnet_ids]
}
