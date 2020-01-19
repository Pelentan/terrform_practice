/*
  Blue instance of Hello World.  Not to be confused with the Green instance of 
  Hello World.  "Hellow World" is right out.
*/

# User data file to set up the base install for the server
data "template_file" "userdata-hblue" {
  template = file("${path.module}/scripts/helloblue.sh")
}

# Instance resource
resource "aws_instance" "hello_blue" {
  ami = var.aws_region_ami[var.aws_region]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-public-1.id  # This should be a private subnet, but still figuring that out
  security_groups = ["${aws_security_group.instance-sg.id}"]
  user_data = data.template_file.userdata-hblue.rendered
}

# Attachement to the Application Loadbalancer
resource "aws_alb_target_group_attachment" "alb-hblue" {
  target_group_arn = aws_alb_target_group.hello-instances.arn
  target_id = aws_instance.hello_blue.id
  port = 80
}

#  Setting up autoscaling isn't working as it should.  Will need to do more investigation.

# resource "aws_launch_configuration" "lc-hello-blue" {
#   name_prefix = "blue-hellos"
#   image_id = "ami-062f7200baf2fa504"
#   instance_type = "t2.micro"
#   security_groups = ["${aws_security_group.instance-sg.id}"]
#   user_data = data.template_file.userdata-hblue.rendered
# }

# resource "aws_autoscaling_group" "hblue-autoscaler" {
#   name = "hblue-autoscaler"
#   vpc_zone_identifier = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
#   launch_configuration = aws_launch_configuration.lc-hello-blue.name
#   min_size = 1
#   max_size = 2
#   health_check_grace_period = 300
#   health_check_type = "EC2"
#   force_delete = true

#   tag {
#     key = "Name"
#     value = "ec2 instance"
#     propagate_at_launch = true
#   }
# }

# # Scale-Up Policy
# resource "aws_autoscaling_policy" "hblue-cpu-policy" {
#   name = "hblue-cpu-policy"
#   autoscaling_group_name = aws_autoscaling_group.hblue-autoscaler.name
#   adjustment_type = "ChangeInCapacity"
#   scaling_adjustment = "1"
#   cooldown = "300"
#   policy_type = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "hblue-cpu-alarm" {
#   alarm_name = "hblue-cpu-alarm"
#   alarm_description = "blue yowza alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "30"

#   dimensions = {
#     "AutoScalingGroupName"= aws_autoscaling_group.hblue-autoscaler.name
#   }

#   actions_enabled = true
#   alarm_actions = ["${aws_autoscaling_policy.hblue-cpu-policy.arn}"]
# }



# # Scale-Down Polich
# resource "aws_autoscaling_policy" "hblue-cpu-policy-down" {
#  name = "hblue-cpu-polich-down"
#  autoscaling_group_name = aws_autoscaling_group.hblue-autoscaler.name 
#  adjustment_type = "ChangeInCapacity"
#  scaling_adjustment = "-1"
#  cooldown = "300"
#  policy_type = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "hblue-cpu-alarm-down" {
#   alarm_name = "hblue-cpu-alarm-down"
#   alarm_description = "when hblue cpu reduces in load"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "5"

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.hblue-autoscaler.name
#   }

#   actions_enabled = true
#   alarm_actions = ["${aws_autoscaling_policy.hblue-cpu-policy-down.arn}"]
# }






