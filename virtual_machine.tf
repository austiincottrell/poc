resource "aws_key_pair" "sshkey" {
  key_name = "sshkey"
  public_key = file(var.ssh_key)
}

resource "aws_instance" "amazonlinux_vm_public" {
  ami = data.aws_ami.rhel7_5.id
  instance_type = var.instance_type
  key_name = aws_key_pair.sshkey.key_name
  subnet_id = aws_subnet.subnet[1].id
  vpc_security_group_ids = [aws_security_group.pub_vm.id]
  root_block_device {
    volume_size = var.vol_size
  }

  tags = {
      Name = local.pub_instance_name
  }
}

resource "aws_instance" "amazonlinux_vm_private" {
  ami = data.aws_ami.rhel7_5.id
  instance_type = var.instance_type
  key_name = aws_key_pair.sshkey.key_name
  subnet_id = aws_subnet.subnet[3].id
  vpc_security_group_ids = [aws_security_group.private_web_server.id]
  root_block_device {
    volume_size = var.vol_size
  }

  tags = {
    Name = local.instance_name
  }
}

output "public_ip" {
  value = aws_instance.amazonlinux_vm_public.public_ip
}

output "private_ip" {
  value = aws_instance.amazonlinux_vm_private.private_ip
}

resource "null_resource" "add_key_to_keychain" {
  provisioner "local-exec" {
    command = "ssh-add -K ${var.key_file}"
  }
}

resource "null_resource" "ssh_config_file" {
  provisioner "local-exec" {
    command = "echo '\nHost bastion-instance \n HostName ${aws_instance.amazonlinux_vm_public.public_ip} \n User ${var.user_os} \n\nHost private-instance \n HostName ${aws_instance.amazonlinux_vm_private.private_ip} \n User ${var.user_os} \n ProxyCommand ssh -q -W %h:%p bastion-instance \n' >> ${var.home_dir}.ssh/config" 
    
    }

  depends_on = [aws_instance.amazonlinux_vm_private]
}
