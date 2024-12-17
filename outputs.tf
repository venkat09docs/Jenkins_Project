output "Jenkins_master_node_public_ip" {
  value = aws_instance.master_server.public_ip
}

output "Jenkins_slave_node_public_ip" {
  value = aws_instance.slave_server.public_ip
}

output "Jenkins_slave_node_private_ip" {
  value = aws_instance.slave_server.private_ip
}