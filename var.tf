variable "my_cidr_block" {
    default = "10.0.0.0/16"
}

variable "subnet_name" {
    type    = list(string)
    default = ["public_1", "public_2", "private_1", "private_2"]
}

variable "public_subnet" {
    type    = list(string)
    default = [true, true, false, false]
}

variable "nacl_ingress_ports" {
    default = [{"port" = 443, "rule" = 110, "type" = "tcp"},{"port" = 80, "rule" = 100, "type" = "tcp"},{"port" = 22, "rule" = 120, "type" = "tcp"},{"port" = 0, "rule" = 150, "type" = "-1"}]
}

variable "instance_type" {
    default = "t2.micro"
}

variable "mykey" {
    default = "sshkey.pub"
}

variable "ssh_key" {
    default = "keys/sshkey.pub"
}

variable "key_file" {
    default = "keys/sshkey"
}

variable "user_os" {
    default = "ec2-user"
}

variable "vol_size" {
    default = "20"
}

locals {
    instance_name = "Web Server"
    pub_instance_name = "Public instance"
    nacl_name = "Private Subnet NACL"
    vpc_name = "Secure VPC"
    alb_name = "Application Load Balaner"
    s3_bucket_name = "pocforcoalfire"
    sg_bastion_host = "Bastion Host"
    sg_private_host = "Web Server security Group"
    sg_for_alb = "ALB security group"
}






variable "myip" {
    
}

variable "home_dir" {
    
}
