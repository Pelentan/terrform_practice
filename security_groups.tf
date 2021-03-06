# Instance Security Group
resource "aws_security_group" "instance-sg" {
  vpc_id = aws_vpc.main.id 
  name = "instance_sg"
  description = "sort of default instance security group."
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Only allows ingress from vpc local address
    security_groups = ["${aws_security_group.app-loadbalancer-sg.id}"]
  }

  /*
    Initial testing I've done is this will allow ssh access using the AWS site EC2 Connnect optiong.  
    However, it will not allow access from anywhere else as it isn't given a key.  If ssh access is 
    necessary I like this added layer of security.   
  */
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "instance-sg"
  }
}

# Loadbalancer Security Group
resource "aws_security_group" "app-loadbalancer-sg" {
  vpc_id = aws_vpc.main.id 
  name = "app-loadbalancer-sg"
  description = "sort of default loadbalancer security group."
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "loadbalancer-sg"
  }
}