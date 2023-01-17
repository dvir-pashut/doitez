resource "aws_instance" "ec2_dvir" {
  count                       = var.ec2-count
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnets-id[count.index]
  vpc_security_group_ids      = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true

  user_data = data.local_file.user-data.content


  tags = merge(var.tags, {
    Name = format("%s-%s",var.ec2-names[count.index],"${terraform.workspace}")
  })
}


resource "aws_lb_target_group" "dvir-tg-tf" {
  name     = "tf-lb-tg-${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id


  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "2"
    interval            = "5"
    path                = "/"

  }

  tags = merge(var.tags, {
    Name = "dvir-tg-tf-${terraform.workspace}"
  })
}

resource "aws_lb_target_group_attachment" "add-ec2s" {
  count            = var.ec2-count
  target_group_arn = aws_lb_target_group.dvir-tg-tf.arn
  target_id        = aws_instance.ec2_dvir[count.index].id
  port             = 80
}


resource "aws_lb" "tf-dvir-alb" {
  count              = (var.ec2-count == 1) ? 0 : 1
  name               = "tf-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http.id]
  subnets            = var.subnets-id
  
  tags = merge(var.tags, {
    Environment = "production"
    name        = "tf-lb-tf-${terraform.workspace}"
  })
}

resource "aws_lb_listener" "front_end" {
  count             = (var.ec2-count == 1) ? 0 : 1
  load_balancer_arn = aws_lb.tf-dvir-alb[count.index].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dvir-tg-tf.arn
  }
}

resource "aws_security_group" "sshhttp" {
  name        = "allow_tls-${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = (var.ec2-count == 1) ? [] : [aws_security_group.http.id]
    cidr_blocks     = (var.ec2-count == 1) ?  ["0.0.0.0/0"] : var.my-ip  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.my-ip
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name = "allow ssh and http-${terraform.workspace}"
  })
}

resource "aws_security_group" "http" {
  name        = "allow_http-${terraform.workspace}"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc-id

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

  tags = merge(var.tags, {
    Name = "allow http-${terraform.workspace}"
  })
}
