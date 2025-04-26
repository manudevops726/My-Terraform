module "dev" {
    source =  "./modules/ec2-instance-module"
    ami_id = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
}



module "rds" {
  source = "./modules/rds"

  identifier                    = "books-rds"
  db_name                       = "manasadatabase"
  engine                        = "mysql"
  engine_version                = "8.0"
  instance_class                = "db.t3.micro"
  username                      = "admin"
  password                      = "manasa1234"
  subnet_ids                    = ["subnet-07f9fcd1f0862b9d1", "subnet-00820a28bf39f07e4"]
  parameter_group_name          = "default.mysql8.0"
  backup_retention_period       = 7
  backup_window                 = "02:00-03:00"
  maintenance_window            = "sun:04:00-sun:05:00"
  deletion_protection           = false
  final_snapshot_identifier     = "books-rds-final-snap"
  skip_final_snapshot           = false
  monitoring_interval           = 60
  monitoring_role_name          = "rds-monitoring-role-20"
  create_monitoring_role        = true
  publicly_accessible           = true
  tags = {
    Name        = "My DB"
    Environment = "dev"
  }
  providers = {
    aws = aws.primary
  }
}


