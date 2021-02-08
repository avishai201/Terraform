output "sg_nginx" {
  value = aws_security_group.allow_web.id
}
output "sg_mysql" {
  value = aws_security_group.mysql.id
}