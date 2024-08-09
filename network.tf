data "aws_availability_zones" "avail_zone" {
    state = "available"
    filter {
        name   = "region-name"
        values = [var.my-region]
}
}

resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_CIDR
    enable_dns_hostnames = true
    tags = {
        Name: "VPC"
    }
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr_block_1
    availability_zone = data.aws_availability_zones.avail_zone.names[0]
    map_public_ip_on_launch = true
    enable_resource_name_dns_a_record_on_launch = true
    tags = {
        Name: "public subnet 1"
        Layer: "web tier"
    }
}
resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr_block_2
    availability_zone = data.aws_availability_zones.avail_zone.names[1]
    map_public_ip_on_launch = true
    enable_resource_name_dns_a_record_on_launch = true
    tags = {
        Name: "public subnet 2"
        Layer: "web tier"
    }
}


resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_block_1
    availability_zone = data.aws_availability_zones.avail_zone.names[0]
    tags = {
        Name: "private subnet 1"
        Layer: "app tier"
    }
}



resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_block_2
    availability_zone = data.aws_availability_zones.avail_zone.names[1]
    tags = {
        Name: "private subnet 2"
        Layer: "app tier"
    }
}
resource "aws_subnet" "private_subnet_3" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_block_3
    availability_zone = data.aws_availability_zones.avail_zone.names[0]
    tags = {
        Name: "private subnet 3"
        Layer: "database tier"

    }
}

resource "aws_subnet" "private_subnet_4" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_block_4
    availability_zone = data.aws_availability_zones.avail_zone.names[1]
    tags = {
        Name: "private subnet 4"
        Layer: "database tier"

    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public_rtp" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rtp.id
}
resource "aws_route_table_association" "public2" {
  subnet_id     = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rtp.id
}

resource "aws_eip" "nat_eip" {
  #instance = aws_instance.web.id
  domain = "vpc"
}


resource "aws_nat_gateway" "public_nat_gw" {
  subnet_id     = aws_subnet.private_subnet_1.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_route_table" "private_rtp" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
   # we need nat gateway here
    nat_gateway_id = aws_nat_gateway.public_nat_gw.id
  }
}
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rtp.id
}
resource "aws_route_table_association" "private2" {
  subnet_id     = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rtp.id
}
resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_rtp.id
}
resource "aws_route_table_association" "private4" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_rtp.id
}
