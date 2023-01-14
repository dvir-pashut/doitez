resource "aws_vpc" "tr_prod_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "tr.prod.vpc"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_subnet" "pub-sub-1" {
  vpc_id     = aws_vpc.tr_prod_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "pub-sub-1"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_subnet" "pub-sub-2" {
  vpc_id     = aws_vpc.tr_prod_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-3b"

  tags = {
    Name = "pub-sub-2"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tr_prod_vpc.id

  tags = {
    Name = "tr-igw"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}


resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.tr_prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-pub"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.rt-pub.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub-sub-2.id
  route_table_id = aws_route_table.rt-pub.id
}


resource "aws_security_group" "sshhttp" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.tr_prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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
    Name = "allow ssh and http"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_security_group" "http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.tr_prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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
    Name = "allow http"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}
