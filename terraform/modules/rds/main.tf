# AWS DB

resource "aws_db_instance" "main_db" {
  identifier             = "${var.env}-db"
  db_name                = var.db_configuration.db_name
  engine                 = var.db_configuration.engine
  engine_version         = var.db_configuration.engine_version
  instance_class         = var.db_configuration.instance_class
  allocated_storage      = var.db_configuration.allocated_storage
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = var.db_configuration.skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.default.name
  multi_az               = var.db_configuration.multi_az
  storage_type           = var.db_configuration.storage_type
  storage_encrypted      = var.db_configuration.storage_encrypted
  vpc_security_group_ids = var.sg_ids_db
  tags = {
    Name        = "${var.env}-main-db"
    Environment = var.env
  }
}

# AWS db subnet group

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.db_subnet_ids
  tags = {
    Name        = "${var.env}-default-db-subnet"
    Environment = var.env
  }
}
