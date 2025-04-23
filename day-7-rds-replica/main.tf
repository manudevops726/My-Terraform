resource "aws_db_instance" "default" {
  

    allocated_storage       = 10
    identifier =             "book-rds"
    db_name                 = "mydb"
    engine                  = "mysql"
    engine_version          = "8.0"
    instance_class          = "db.t3.micro"
    username                = "admin"
    password                = "manasa123"
    db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
    parameter_group_name    = "default.mysql8.0"
    provider = aws.primary
 
   # Enable backups and retention
     backup_retention_period  = 7   # Retain backups for 7 days
     backup_window            = "02:00-03:00" # Daily backup window (UTC)
 
   # Enable monitoring (CloudWatch Enhanced Monitoring)
     monitoring_interval      = 60  # Collect metrics every 60 seconds
     monitoring_role_arn      = aws_iam_role.rds_monitoring3.arn
 
   # Enable performance insights
   #   performance_insights_enabled          = true
   #   performance_insights_retention_period = 7  # Retain insights for 7 days
 
   # Maintenance window
      maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)
 
   # Enable deletion protection (to prevent accidental deletion)
      deletion_protection = false
      final_snapshot_identifier = "books-rds-final-snap"
 
   # Skip final snapshot
       skip_final_snapshot = false
 }
 
 # IAM Role for RDS Enhanced Monitoring
 resource "aws_iam_role" "rds_monitoring3" {
   name = "rds-monitoring3-role"
   provider = aws.primary
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Principal = {
         Service = "monitoring.rds.amazonaws.com"
       }
     }]
   })
 }
 
 # IAM Policy Attachment for RDS Monitoring
 resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
     provider = aws.primary
     role       = aws_iam_role.rds_monitoring3.name
     policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
 }
 
 
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = ["subnet-01a250dab6e1fefb0", "subnet-072836e46cd8bd369"]
  provider   = aws.primary

    tags = {
     Name = "My DB subnet group"
   }
 }
 
 resource "aws_db_instance" "read_replica" {
  provider               = aws.secondary
  identifier             = "read-replica-instance"
  replicate_source_db    = aws_db_instance.default.arn
  instance_class         = "db.t3.micro"
  publicly_accessible    = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.replica.name
#   vpc_security_group_ids = [aws_security_group.db_sg.id]
  depends_on             = [aws_db_instance.default]
}

# DB Subnet Group for replica
resource "aws_db_subnet_group" "replica" {
  provider = aws.secondary
  name     = "replica-subnet-group"
  subnet_ids = [
    "subnet-01691632d557af4f7", # replace with subnets in us-east-1
    "subnet-062a39965e275de1d"
  ]
}