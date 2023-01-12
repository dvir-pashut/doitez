resource "aws_lb_target_group" "dvir-tg-tf" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tr_prod_vpc.id
   
   
   health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "2"
    interval            = "5" 
    path                = "/"
    
   }

   tags = {
    Name = "dvir-tg-tf"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
   }
   depends_on = [
     aws_instance.ec2_dvir1,aws_instance.ec2_dvir2,aws_vpc.tr_prod_vpc
   ]
}

resource "aws_lb_target_group_attachment" "add-ec2-1" {
  target_group_arn = aws_lb_target_group.dvir-tg-tf.arn
  target_id        = aws_instance.ec2_dvir1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "add-ec2-2" {
  target_group_arn = aws_lb_target_group.dvir-tg-tf.arn
  target_id        = aws_instance.ec2_dvir2.id
  port             = 80
}

resource "aws_lb" "tf-dvir-alb" {
  name               = "tf-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http.id]
  subnets           = [aws_subnet.pub-sub-1.id,aws_subnet.pub-sub-2.id]

  tags = {
    Environment = "production"
    name = "tf-lb-tf"
    Owner ="dvir-pashut"
    experation_date = "01-04-2023"
    bootcamp = "17"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.tf-dvir-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dvir-tg-tf.arn
  }
}
