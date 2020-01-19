/*
  Green instance of Hello World.  Not to be confused with the Blue instance of 
  Hello World.  "Hellow World" is right out.
*/

# User data file to set up the base install for the server
data "template_file" "userdata-hgreen" {
  template = file("${path.module}/scripts/hellogreen.sh")
}

# Instance resource
resource "aws_instance" "hello_green" {
  ami = var.aws_region_ami[var.aws_region]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-public-2.id  # This should be a private subnet, but still figuring that out
  security_groups = ["${aws_security_group.instance-sg.id}"]
  user_data = data.template_file.userdata-hgreen.rendered
}

# Attachement to the Application Loadbalancer
resource "aws_alb_target_group_attachment" "alb-hgreen" {
  target_group_arn = aws_alb_target_group.hello-instances.arn
  target_id = aws_instance.hello_green.id
  port = 80
}





