provider "aws" {
  region = "us-east-1" 
}

resource "aws_security_group" "example" {
  name        = "RDS-Access-SG"  
  description = "Allow traffic to RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_db_instance" "example" {
  identifier           = "rds-webapp-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0" 
  instance_class       = "db.t3.micro"
  db_name              = "web_app_db"
  username             = "admin"
  password             = "your_password"
  vpc_security_group_ids   = [aws_security_group.example.id]
  db_subnet_group_name = "webtier-db-subnetgroup"
  publicly_accessible  = false
  skip_final_snapshot  = true
}
