resource "aws_security_group" "rds-sg" {
  name        = "RDS-SG"  
  description = "Allow traffic to RDS"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_1.cidr_block , aws_subnet.private_subnet_2.cidr_block] 
    #prefix_list_ids = [ aws_security_group.app-sg.id ]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_1.cidr_block , aws_subnet.private_subnet_2.cidr_block] 
    #prefix_list_ids = [ aws_security_group.app-sg.id ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_security_group" "web-sg" {
  name        = "web-SG"  
  description = "Allow traffic to web"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_security_group" "app-sg" {
  name        = "app-SG"  
  description = "Allow traffic to RDS"
  vpc_id      = aws_vpc.my_vpc.id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet_1.cidr_block , aws_subnet.public_subnet_2.cidr_block] 
    #prefix_list_ids = [ aws_security_group.web-sg.id ]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet_1.cidr_block , aws_subnet.public_subnet_2.cidr_block] 
    #prefix_list_ids = [ aws_security_group.web-sg.id ]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_1.cidr_block , aws_subnet.private_subnet_2.cidr_block] 
    #prefix_list_ids = [ aws_security_group.web-sg.id ]

  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_4.cidr_block , aws_subnet.private_subnet_3.cidr_block] 
    #prefix_list_ids = [ aws_security_group.rds-sg.id ]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }  
}