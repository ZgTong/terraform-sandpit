output "db_private_ip" {
  value = aws_instance.db.private_ip
}

output "db_instance_id" {
  value = aws_instance.db.id
}
