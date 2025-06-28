resource "aws_vpc" "wordpress_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "wordpress_vpc"
  }
}


resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true 

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true 

  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private1"
  }
}
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private2"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "wordpress-igw"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "wordpress-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw .id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}