# I put "this" cnnfiguration in "this" file because this is for showing output
output "instance_public_ips" {
  value = { for i in aws_instance.ubuntu: i.tags.Name => i.public_ip }
}
