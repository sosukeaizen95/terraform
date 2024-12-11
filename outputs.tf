output "InstanceId" {
    description = "ID of the newly created instance"
    value = aws_instance.ns_ec2_1.id
}
output "PublicIpAddress" {
    description = "publicly accessible ip address as an output"
    value = aws_instance.ns_ec2_1.public_ip
}