variable "instance_type" {
  default = "t2.micro"
}

variable "sg" {
  description = "security group"
}

variable "ami" {
  description = "Ubuntu Server 20.04 LTS , - ami-0a91cd140a1fc148a"
}

variable "subnet" {
  description = "public/private subnet"
}

variable "tag_name" {
  description = "ec2 tag name"
}

variable "file" {
  description = "bash file"
}