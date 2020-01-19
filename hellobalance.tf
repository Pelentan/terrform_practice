# resource "aws_lb" "hello_lb" {
#   name = "hello-loadbalancer"
#   internal = false
#   load_balancer_type = "application"
#   security_groups = ["${aws_security_group.hw_loadbalancer.id}"]
#   subnets         = [aws_subnet.main.*.id[0], aws_subnet.main.*.id[1]]
#   enable_deletion_protection = true
  
# }

resource "aws_alb_target_group" "hello-instances" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

resource "aws_alb" "hello_lb" {
    name = "hello-loadbalancer"
    subnets  = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
    security_groups = ["${aws_security_group.app-loadbalancer-sg.id}"]
}

resource "aws_alb_listener" "hello-listeners" {
  load_balancer_arn = aws_alb.hello_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
      target_group_arn = aws_alb_target_group.hello-instances.arn
      type = "forward"
  }
}

