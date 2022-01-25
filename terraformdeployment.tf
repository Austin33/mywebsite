provider "aws" {
  access_key = "???" #replace with your own credentials
  secret_key = "???" #replace with your own credentials
  region     = "us-east-1"
}

data "aws_availability_zones" "all" {}



variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

resource "aws_launch_configuration" "webservgroup1" {
  image_id = "ami-0cf4275f089445589"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              git clone https://github.com/Austin33/mywebsite.git
              cd mywebsite
              docker-compose.yml up -d
              EOF
  lifecycle {create_before_destroy = true}
}

resource "aws_autoscaling_group" "webservgroup1" {
  launch_configuration = "${aws_launch_configuration.webservgroup1.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  max_size = 10
  min_size = 2

  load_balancers = ["${aws_elb.austlb1.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "asg-example"
    propagate_at_launch = true
  }
}

output "elb_dns_name" {
  value = "${aws_elb.austlb1.dns_name}"
}

resource "aws_elb" "austlb1" {
  name = "austinwebservlb"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:${var.server_port}/"
    timeout = 3
    unhealthy_threshold = 2
  }
  listener {
    instance_port = "${var.server_port}"
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}

resource "aws_security_group" "elb" {
  name = "austinswebsite-elb"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "webserv1" {
  ami           = "ami-0cf4275f089445589"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "austins-webserver"
  }
}

resource "aws_security_group" "instance" {
  name = "austinswebserverinstance"

  ingress {
    from_port = "${var.server_port}"
    protocol = "tcp"
    to_port = "${var.server_port}"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {create_before_destroy = true}
}

output "public_ip" {
  value = "${aws_instance.webserv1.public_ip}"
}