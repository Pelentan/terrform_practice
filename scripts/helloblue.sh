#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "<body style = 'background-color:blue'><h1>Hello World from $(hostname -f)</h1></body>" > /var/www/html/index.html
