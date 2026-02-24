output "ins_publicdns" {
  description = "public DNS"
  # value = aws_instance.terraform_ec2.*.public_dns
  # value = aws_instance.terraform_ec2[*].public_dns
  # value = toset([for ins in aws_instance.terraform_ec2: ins.public_dns])
  # value = tomap({for ins in aws_instance.terraform_ec2: ins.id => ins.public_dns})
  value = tomap({for c, ins in aws_instance.terraform_ec2: c => ins.public_dns})
}

output "ins_publicip" {
  description = "public IP"
  value = toset([for ins in aws_instance.terraform_ec2: ins.public_ip])
}