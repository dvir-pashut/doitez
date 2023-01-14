resource "aws_instance" "ec2_dvir1" {
  ami           = "ami-03c476a1ca8e3ebdc"
  instance_type = "t3a.micro"
  subnet_id = aws_subnet.pub-sub-1.id
  vpc_security_group_ids = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true
  
  user_data = <<-EOF
    #!/bin/bash

    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    apt-get update
    apt-get install -y docker-ce
    usermod -aG docker ubuntu 
    newgrp docker
    docker run -d -p 80:3000 adongy/hostname-docker
    EOF
    depends_on = [
      aws_subnet.pub-sub-1,aws_security_group.sshhttp
    ]

  tags = {
    Name = "dvir-prod-ec2-tr-yes-this-is-long-name1"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_instance" "ec2_dvir2" {
  ami           = "ami-03c476a1ca8e3ebdc"
  instance_type = "t3a.micro"
  subnet_id = aws_subnet.pub-sub-2.id
  vpc_security_group_ids = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true
  
  user_data = <<-EOF
    #!/bin/bash

    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    apt-get update
    apt-get install -y docker-ce
    usermod -aG docker ubuntu 
    newgrp docker
    docker run -d -p 80:3000 adongy/hostname-docker
    EOF
    
    depends_on = [
      aws_subnet.pub-sub-2,aws_security_group.sshhttp
    ] 

  tags = {
    Name = "dvir-prod-ec2-tr-yes-this-is-long-name2"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

