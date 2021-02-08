## security group to allow port 80,443,8080 and ssh
resource "aws_security_group" "allow_web" {
  name = "allow_web_traffic"
  description = "Allow inbound web traffic"
  vpc_id = var.vpc_id


  dynamic "ingress" {
    for_each = ["80", "443", "8080" ,"22"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "All networks allowed"
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    "Name" = "allow_web"
  }

}

## security group to allow my sql
resource "aws_security_group" "mysql" {
  name = "mysql"
  description = "Allow inbound mysql traffic"
  vpc_id = var.vpc_id


  dynamic "ingress" {
    for_each = ["3306", "33060"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "All networks allowed"
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    "Name" = "mysql"
  }

}