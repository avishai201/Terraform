resource "aws_network_interface" "server-nic" {
  subnet_id =  var.subnet
  security_groups = [ var.sg ]
}

# 10- Create a new ubuntu instance
resource "aws_instance" "my-instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = "newkey"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.server-nic.id
  }
  user_data = file (var.file)
  tags = {
    "Name" = var.tag_name
  }
}
