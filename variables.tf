variable "region" {
    description = "AWS region where the instance will be deployed."
    default = "us-east-2"
}

variable "key_name" {
    description = "Name of the SSH key to be installed on the instance."
    default = "key1"
}

variable "instance_type" {
    description = "EC2 instance type (i.e size of the instance)."
    default = "t2.micro"
}

variable "subnet_id" {
    description = "ID of the subnet where the instance will be deployed."
    default = "subnet-06713afd347c5ee1a"
}

variable "vpc_id" {
    description = "ID of the VPC where the instance will be deployed."
    default = "vpc-092dfcfc1ef4080d2"
}
