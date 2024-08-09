resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_3.id , aws_subnet.private_subnet_4.id ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds" {
  identifier           = "rds-web-app-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0" 
  instance_class       = var.db_instance_type
  db_name              = "web_app_db"
  username             = "admin"
  password             = "1234asAS"
  vpc_security_group_ids   = [ aws_security_group.rds-sg.id ]
  db_subnet_group_name =  aws_db_subnet_group.db_subnet.name
  publicly_accessible  = false
  skip_final_snapshot  = true
}

