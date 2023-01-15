resource "aws_instance" "ec2_dvir1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.pub-sub-1.id
  vpc_security_group_ids      = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true

  user_data = var.user_data


  tags = merge(var.tags, {
    Name = "dvir-prod-ec2-tr-yes-this-is-long-name1"
  })
}

resource "aws_instance" "ec2_dvir2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.pub-sub-2.id
  vpc_security_group_ids      = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true

  user_data = var.user_data

  tags = merge(var.tags, {
    Name = "dvir-prod-ec2-tr-yes-this-is-long-name2"
  })
}


